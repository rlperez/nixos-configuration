#!/usr/bin/env bash
set -euo pipefail

script_dir="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
repo_path="$(realpath -- "$script_dir/..")"
cd "$repo_path"

nix develop -c nvfetcher
nix flake update;

git add flake.lock _sources/

sudo nixos-rebuild switch --flake "path:$repo_path"
git commit -m "Performed system update at $(date '+%F_%H:%M:%S')"
