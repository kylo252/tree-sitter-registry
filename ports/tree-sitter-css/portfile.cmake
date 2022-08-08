set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-css
  REF 7c390622166517b01445e0bb08f72831731d3088
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE css
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

