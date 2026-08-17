#!/usr/bin/env bash
set -euo pipefail

: "${REPO_PATH:?REPO_PATH is not set}"

cd "$REPO_PATH"

nix develop -c nvfetcher "$@"
