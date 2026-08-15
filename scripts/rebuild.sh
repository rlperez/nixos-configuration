#!/usr/bin/env bash
set -euo pipefail

: "${REPO_PATH:?REPO_PATH is not set}"

cd "$REPO_PATH"

exec nixos-rebuild switch --flake "path:$REPO_PATH"
