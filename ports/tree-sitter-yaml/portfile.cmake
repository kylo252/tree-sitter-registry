set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ikatyang/tree-sitter-yaml
  REF 6129a83eeec7d6070b1c0567ec7ce3509ead607c
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE yaml
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

