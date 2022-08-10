#!/usr/bin/env bash
set -e

REPO_ROOT=$(git rev-parse --show-toplevel)
export VCPKG_ROOT=${VCPKG_ROOT:-"$HOME/.local/share/vcpkg"}

vcpkg(){
  "$VCPKG_ROOT"/vcpkg "$@"
}

vcpkg x-add-version --overwrite-version --all \
  --x-builtin-ports-root="$REPO_ROOT/ports" \
  --x-builtin-registry-versions-dir="$REPO_ROOT/versions"

vcpkg format-manifest --all
