#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

scripts/update-flake.sh
scripts/update-nvfetcher.sh --commit-changes
scripts/rebuild.sh
