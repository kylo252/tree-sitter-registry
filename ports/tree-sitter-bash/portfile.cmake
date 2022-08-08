set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-bash
  REF 4094e3a0405aabb1314c0c41f29e38e70af86fa5
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE bash
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

