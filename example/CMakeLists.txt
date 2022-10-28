cmake_minimum_required(VERSION 3.24)
project(demo)

include(FindPkgConfig)
find_package(PkgConfig REQUIRED)
pkg_check_modules(TS_JSON REQUIRED IMPORTED_TARGET tree-sitter-json)

find_package(unofficial-tree-sitter CONFIG REQUIRED)

add_executable(test test-json-parser.c)
target_link_libraries(test PRIVATE unofficial::tree-sitter::tree-sitter PkgConfig::TS_JSON)
