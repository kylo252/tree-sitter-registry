#!/usr/bin/env bash

nvim --headless -c "luafile ./scripts/write-manifests.lua" -c "q"

vcpkg format-manifest --all --vcpkg-root=.
