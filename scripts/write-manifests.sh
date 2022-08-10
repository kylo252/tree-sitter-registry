#!/usr/bin/env bash
set -e

REPO_ROOT=$(git rev-parse --show-toplevel)

nvim --headless -c "luafile $REPO_ROOT/scripts/write-manifests.lua" -c "q"

bash "$REPO_ROOT/scripts/add_versions.sh"
