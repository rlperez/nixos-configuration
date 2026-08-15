#!/usr/bin/env bash
set -euo pipefail

: "${REPO_PATH:?REPO_PATH is not set}"
: "${GIT_USERNAME:?GIT_USERNAME is not set}"

cd "$REPO_PATH"

exec runuser -u "$GIT_USERNAME" -- nix flake update
