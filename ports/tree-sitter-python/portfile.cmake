set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-python
  REF 188b6b062d8cb256e7dfe76b5ad5089bbdcb7014
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE python
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

