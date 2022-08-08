set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-json
  REF 67d33d619e4fb729432a6d9aff1f7b08bb563728
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE json
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

