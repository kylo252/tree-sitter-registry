set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-c
  REF 0720f9c2af2a97dcd0e9ed90324d1baba68b2849
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE c
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

