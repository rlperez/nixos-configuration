#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

scripts/update-flake.sh
scripts/rebuild.sh
