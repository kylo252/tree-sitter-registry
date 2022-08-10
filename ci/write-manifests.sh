#!/usr/bin/env bash
set -e

REPO_ROOT=$(git rev-parse --show-toplevel)

nvim --headless -c "luafile $REPO_ROOT/ci/write-manifests.lua" -c "q"

bash "$REPO_ROOT/ci/add_versions.sh"
