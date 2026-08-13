#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

nixos-rebuild switch --flake path:.
