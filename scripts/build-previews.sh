#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workdir="$(mktemp -d "${TMPDIR:-/tmp}/black-metal-previews.XXXXXX")"
output_dir="${1:-$root/previews}"
obsimusic_root="${OBSIMUSIC_ROOT:-$root/../obsimusic}"
trap 'rm -rf "$workdir"' EXIT

mkdir -p "$workdir/html" "$workdir/artwork" "$output_dir"

artwork_dir="$output_dir/.artwork"
mkdir -p "$artwork_dir"
OBSIMUSIC_ROOT="$obsimusic_root" ruby "$root/scripts/fetch-theme-artwork.rb" "$artwork_dir"

while IFS= read -r theme; do
  for colorscheme in "$theme" "$theme-alt" "$theme-light" "$theme-light-alt"; do
    nvim --headless -u NONE \
      --cmd "set rtp^=$root" \
      -c "packadd nvim.tohtml" \
      -c "set syntax=ruby number nowrap" \
      -c "edit $root/scripts/preview.rb" \
      -c "lua require('black-metal').setup({ trve = false })" \
      -c "colorscheme $colorscheme" \
      -c "syntax on" \
      -c "TOhtml" \
      -c "w! $workdir/html/$colorscheme.html" \
      -c "qa!"
  done
done < <(find "$root/colors" -maxdepth 1 -type f -name '*.lua' \
  ! -name '*-alt.lua' ! -name '*-light.lua' ! -name '*-light-alt.lua' \
  -exec basename {} .lua \; | sort)

node "$root/scripts/render-previews.mjs" "$workdir/html" "$output_dir"
node "$root/scripts/compose-previews.mjs" "$artwork_dir/artwork.json" "$output_dir"

printf 'Theme previews and collages written to %s\n' "$output_dir"
