#!/usr/bin/env bash

nvim --headless -c "luafile ./scripts/write-manifests.lua" -c "q"

# Pretty print
cp vcpkg.json /tmp/vcpkg.json
cat /tmp/vcpkg.json | jq --sort-keys > vcpkg.json
