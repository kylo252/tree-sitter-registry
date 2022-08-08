set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-rust
  REF 0f14a10011ac6e56f309fb99a94829c3312b743a
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE rust
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

