#!/usr/bin/env bash

function calculate_sha512(){
  local repo=${1}
  local commit temp hash
  temp=$(mktemp)
  commit=$(gh api "/repos/${repo}/commits" -q '.[1].sha')
  curl -LSs "https://github.com/${repo}/archive/${commit}.tar.gz" --output "${temp}" &>/dev/null
  hash=$(openssl dgst -sha512 "${temp}" | awk '{print $2}')
  printf "%s\t%s\n" "${commit}" "${hash}"
}

calculate_sha512 "$@"
