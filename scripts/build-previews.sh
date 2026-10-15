#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output_dir="${1:-$root/previews}"
obsimusic_root="${OBSIMUSIC_ROOT:-$root/../obsimusic}"
wiki_dir="${WIKI_DIR:-$root/../black-metal-theme-neovim.wiki}"

wiki_parent="$(dirname "$wiki_dir")"
wiki_dir="$(cd "$wiki_parent" && pwd -P)/$(basename "$wiki_dir")"
if [[ -d "$wiki_dir" ]]; then
  wiki_dir="$(cd "$wiki_dir" && pwd -P)"
fi
case "$wiki_dir/" in
  "$root/"*)
    printf 'Wiki output must be outside the theme repository: %s\n' "$wiki_dir" >&2
    exit 1
    ;;
esac
if ! git -C "$wiki_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'Wiki directory is not a Git checkout: %s\nCreate the GitHub Wiki first, clone it locally, or set WIKI_DIR to its checkout.\n' "$wiki_dir" >&2
  exit 1
fi

workdir="$(mktemp -d "${TMPDIR:-/tmp}/black-metal-previews.XXXXXX")"
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
node "$root/scripts/generate-preview-wiki.mjs" "$output_dir" "$wiki_dir"

printf 'Theme previews and collages written to %s\n' "$output_dir"
printf 'Wiki page and images written to %s\n' "$wiki_dir"
