set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-cpp
  REF 9a877b6180cfc419622363fa56205505565b4a4f
  SHA512 6e5eff8e385f2d1526ccb8537fd0b4b40175636f6122d25fe3e7dadec242203f8f96e0ff5e52d5162a5c85e4a383d99a14bff44aa5c6e5cf439ce393ecb78e01
  HEAD_REF master
)

vcpkg_add_ts_parser(
  LANGUAGE cpp
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

