set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  test @test@
  REF foo
  SHA512 @SHA512@
  HEAD_REF master
)

vcpkg_ts_parser_add(
  LANGUAGE bar
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION @ABI_VER@
)

