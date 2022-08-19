# tree-sitter-registry

A [vcpkg](https://github.com/microsoft/vcpkg) registry for building and installing tree-sitter parsers.

The plan is to eventually upstream all of this, see [microsoft/vcpkg#26272](https://github.com/microsoft/vcpkg/pull/26272)

#### Features

- cross-platform support powered by cmake and vcpkg
- allows both dynamic and static builds
- strict ABI versioning, but can still be overridden with
  [`--overlay-ports=<path>`](https://github.com/microsoft/vcpkg/blob/e99d9a4facea9d7e15a91212364d7a12762b7512/docs/commands/common-options.md#--overlay-portspath)
- helper function for integrating additional parsers, see [ports/tree-sitter-common](ports/tree-sitter-common)

#### How to use it?

- [install `vcpkg`](https://vcpkg.io/en/getting-started.html)
- copy both config files from `example` into the desired folder
- run `vcpkg install` (a.k.a. manifest mode) in that folder

Check [.github/workflows/vcpkg.yml](.github/workflows/vcpkg.yml) for a full example.

#### How does it work?

use a common [`CMakeLists.txt`](ports/tree-sitter-common/CMakeLists.txt.in) that knows how to build all these parsers.

##### Background about parsers

- each parser requires building one or two C/C++ generated files (`parser.c`, `scanner.[c|cc]`)
- the generated files do not include any external C/C++ dependencies
- currently, these generated files are checked in into the repo, but the might change
- `tree-sitter-cli` is used to generate these files in case of an ABI version mismatch
  > Tree-sitter grammars are written in JavaScript, and Tree-sitter uses
  > [Node.js](https://nodejs.org/) to interpret JavaScript files. It requires the node command to be
  > in one of the directories in your [PATH](https://en.wikipedia.org/wiki/PATH_(variable)). You’ll
  > need Node.js version 6.0 or greater.

##### ABI stability

> The Tree-sitter library can be used with language parsers that were built with an older version of
> Tree-sitter, but the reverse does not work. The exact language versions that work with the current
> library version are defined by [these two
> constants](https://github.com/tree-sitter/tree-sitter/blob/34de25ce54c99b76d9ad4628af5c2569dd737b6b/lib/include/tree_sitter/api.h#L17-L18)
> in `api.h`.

I'm currently imposing a specific ABI version, but still trying to [make it clear how to override
it](https://github.com/kylo252/tree-sitter-registry/blob/0c0d91c2fbaef602f4308e633778023d0c8e3596/ports/tree-sitter-common/vcpkg_ts_parser_add.cmake#L19-L23),
which requires `tree-sitter-cli`

#### Available parsers

- [Bash](https://github.com/tree-sitter/tree-sitter-bash)
- [C](https://github.com/tree-sitter/tree-sitter-c)
- [C++](https://github.com/tree-sitter/tree-sitter-cpp)
- [CSS](https://github.com/tree-sitter/tree-sitter-css)
- [JavaScript](https://github.com/tree-sitter/tree-sitter-javascript)
- [JSON](https://github.com/tree-sitter/tree-sitter-json)
- [Lua](https://github.com/Azganoth/tree-sitter-lua)
- [Python](https://github.com/tree-sitter/tree-sitter-python)
- [Rust](https://github.com/tree-sitter/tree-sitter-rust)
- [TypeScript](https://github.com/tree-sitter/tree-sitter-typescript)
- [YAML](https://github.com/ikatyang/tree-sitter-yaml)

#### References

- [Registries: Bring your own libraries to vcpkg](https://devblogs.microsoft.com/cppblog/registries-bring-your-own-libraries-to-vcpkg)
- [Selecting library features](https://github.com/microsoft/vcpkg/blob/master/docs/users/selecting-library-features.md)
- [Tree-sitter's documentation](https://tree-sitter.github.io)
