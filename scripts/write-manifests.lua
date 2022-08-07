-- Execute as `nvim --headless -c "luafile ./scripts/write-manifests.lua"`

local parsers = require("nvim-treesitter.parsers")

local uv = vim.loop

vim.json.encode_escape_forward_slash(false)

local function join_paths(...)
  local path_sep = uv.os_uname().version:match("Windows") and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

local function call_proc(process, opts, cb)
  local std_output = ""
  local error_output = ""

  local function onread(handle, is_stderr)
    return function(err, data)
      if data then
        if is_stderr then
          error_output = (error_output or "") .. data
        else
          std_output = (std_output or "") .. data
        end
      end
    end
  end

  local handle

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local stdio = { nil, stdout, stderr }

  handle = uv.spawn(
    process,
    { args = opts.args, cwd = uv.cwd(), stdio = stdio },
    vim.schedule_wrap(function(code)
      if code ~= 0 then
        stdout:read_stop()
        stderr:read_stop()
      end

      local check = uv.new_check()
      check:start(function()
        for _, pipe in ipairs(stdio) do
          if pipe and not pipe:is_closing() then
            return
          end
        end
        check:stop()
        handle:close()
        cb(code, std_output, error_output)
      end)
    end)
  )

  uv.read_start(stdout, onread(handle, false))
  uv.read_start(stderr, onread(handle, true))

  return handle
end

local locked_parsers = {}

local completed = 0

local function generate_metadata(verbose, filtered_parsers)
  local requested_parsers = {}
  local active_jobs = {}
  -- Load previous lockfile
  filtered_parsers = filtered_parsers
      or {
        "bash",
        "c",
        "javascript",
        "json",
        "lua",
        "python",
        "typescript",
        "css",
        "rust",
        "yaml",
      }

  for k, v in pairs(parsers.get_parser_configs()) do
    if vim.tbl_contains(filtered_parsers, k) then
      table.insert(requested_parsers, { name = k, parser = v })
    end
  end

  table.sort(requested_parsers, function(a, b)
    return a.name < b.name
  end)

  for _, v in ipairs(requested_parsers) do
    local url = v.parser.install_info.url
    local revision = v.parser.revision
    local repo = url:gsub("https://github.com/", "")
    local branch = v.parser.branch or "master"
    local abi = v.parser.abi or 13

    locked_parsers[v.name] = {
      name = url:gsub("https://github.com/%S+/", ""),
      homepage = url,
      supports = "!uwp",
      dependencies = {
        {
          name = "tree-sitter-common",
          host = true,
        },
        {
          name = "vcpkg-cmake",
          host = true,
        },
        {
          name = "vcpkg-cmake-config",
          host = true,
        },
      },
      ref = branch,
      abi = abi,
    }

    local add_revision = function(success, result, errors)
      completed = completed + 1
      if not success then
        print("error: " .. errors)
        return
      end
      locked_parsers[v.name].revision = result:gsub("\n", "")
    end

    local add_desc = function(success, result, errors)
      completed = completed + 1
      if not success then
        print("error: " .. errors)
        return
      end

      locked_parsers[v.name].description = result:gsub("\n", "")
    end

    local add_license = function(success, result, errors)
      completed = completed + 1
      if not success then
        print("error: " .. errors)
        return
      end

      locked_parsers[v.name].license = result:gsub("\n", "")
    end

    local get_rev = call_proc("gh", { args = { "api", "/repos/" .. repo .. "/commits", "-q", ".[1].sha" } }, add_revision)
    table.insert(active_jobs, get_rev)

    local get_desc = call_proc("gh", { args = { "api", "/repos/" .. repo, "-q", ".description" } }, add_desc)
    table.insert(active_jobs, get_desc)

    local get_license = call_proc("gh", { args = { "api", "/repos/" .. repo, "-q", ".license.spdx_id" } }, add_license)
    table.insert(active_jobs, get_license)
  end

  print("active: " .. #active_jobs)
  print("parsers: " .. #requested_parsers)

  vim.wait(#active_jobs * 60 * 1000, function()
    return completed == #active_jobs
  end)

  if verbose then
    print(vim.inspect(locked_parsers))
  end

  local output = join_paths(uv.cwd(), "parsers.lua")
  local fd = assert(io.open(output, "w"))
  fd:write("return " .. vim.inspect(locked_parsers), "\n")
  fd:flush()
end

local function write_manifests()
  local parsers_file = join_paths(uv.cwd(), "parsers.lua")
  local parsers_info = dofile(parsers_file)

  for _, v in pairs(parsers_info) do
    print("creating: " .. v.name)
    local prefix = join_paths(uv.cwd(), "ports", v.name)
    os.execute("mkdir -p " .. prefix)

    local manifest = vim.deepcopy(v)
    manifest.abi = nil
    manifest.revision = nil
    manifest.ref = nil
    manifest["version-date"] = os.date("%Y-%m-%d")
    local output = join_paths(prefix, "vcpkg.json")
    local fd = assert(io.open(output, "w"))
    fd:write(vim.json.encode(manifest), "\n")
    fd:flush()
  end
end

generate_metadata()
write_manifests()
