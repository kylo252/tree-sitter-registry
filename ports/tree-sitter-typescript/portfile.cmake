set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-typescript
  REF c94f0d5c31944beecdd14b39e185f816e95dbe6d
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE typescript
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

