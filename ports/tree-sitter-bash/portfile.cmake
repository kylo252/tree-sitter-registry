set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO tree-sitter/tree-sitter-bash
  REF 4094e3a0405aabb1314c0c41f29e38e70af86fa5
  SHA512 53b4f8f796f62526583795e4ffc0b8c4f410420f34cb12fa4e8b87129519796775b0f3d604a1d1bd497f2de44981aad88ac651aaccfc5ba969063092c34e9379
  HEAD_REF master
)

vcpkg_add_ts_parser(
  LANGUAGE bash
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

