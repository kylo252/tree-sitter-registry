set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-javascript
  REF 90e54fd058cf5412be73aa4061cd0ee0e7e9ccc6
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE javascript
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

