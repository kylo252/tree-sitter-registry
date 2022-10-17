set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ikatyang/tree-sitter-yaml
  REF 6129a83eeec7d6070b1c0567ec7ce3509ead607c
  SHA512 ccf9b42c560c819a685cefec98f254704fd40824e6b02d68fd3ae1807b8541a2abbfb0d0340461e811441c80be79f17a11ad226ea3edc527054d7cfd670136fe
  HEAD_REF master
)

vcpkg_add_ts_parser(
  LANGUAGE yaml
  SOURCE_PATH "${SOURCE_PATH}"
  MIN_ABI_VERSION 13
)

