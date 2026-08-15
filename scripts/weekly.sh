#!/usr/bin/env bash
set -euo pipefail

: "${REPO_PATH:?REPO_PATH is not set}"
: "${GIT_USERNAME:?GIT_USERNAME is not set}"

cd "$REPO_PATH"

scripts/update-flake.sh
scripts/update-nvfetcher.sh --commit-changes
scripts/rebuild.sh
