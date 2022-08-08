set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO MunifTanjim/tree-sitter-lua
  REF 88ad75ba99ed61d67f9f8fbc076abe9464b38e96
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE lua
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

