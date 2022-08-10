#!/usr/bin/env bash
set -e

REPO_ROOT=$(git rev-parse --show-toplevel)
VCPKG_ROOT=${VCPKG_ROOT:-"$HOME/.local/share/vcpkg"}

vcpkg(){
  pushd "$VCPKG_ROOT" >/dev/null
  ./vcpkg "$@"
  popd >/dev/null
}

vcpkg x-add-version --all \
  --x-builtin-ports-root="$REPO_ROOT/ports" \
  --x-builtin-registry-versions-dir="$REPO_ROOT/versions"

vcpkg format-manifest --all --vcpkg-root="$REPO_ROOT"
