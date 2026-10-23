# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v2.4.0 - 2026-10-23

- migrate Eza extras from `EZA_COLORS` shell files (`extras/eza/<theme>.sh`) to `theme.yml` files (`extras/eza/<theme>.yml`); requires eza >= 0.19.2
- **breaking:** the `.sh` files are removed; copy the `.yml` file to `~/.config/eza/theme.yml` and unset `EZA_COLORS`, which overrides `theme.yml`
- color keys that `EZA_COLORS` could not set (`file_type`, `git_repo`, `security_context`, `punctuation`, ...) now use palette colors instead of eza defaults
- validate generated Eza themes in `scripts/check-extras.lua` by parsing the YAML and running eza

## v2.3.0 - 2026-10-17

- add Helix theme generation for all themes and variants
- add Eza themes and generate extras for dark, dark-alt, light, and light-alt variants
- brighten default foreground from `#c1c1c1` to `#f1f1f1`
- allow dynamic highlight overrides with palette references and callbacks

## v2.2.0 - 2026-10-07

- give every light theme its own tinted background, ink, comments, selection, and accent-derived syntax colors
- add `<band_name>-light` and `<band_name>-light-alt` colorschemes for all themes
- improve light-variant Markdown code backgrounds and color headings by level
- preserve setup options when switching themes with `:colorscheme`
- allow `colors.dark` and `colors.light` sub-tables to override one variant
- fix light-variant cursor-line, float, and picker backgrounds
- fix crash when underline styling is disabled
- add light-palette distinction and contrast checks

## v2.1.0 - 2026-09-21

- add configuration for disabling underline and undercurl styles
- make FloatBorder transparent when transparent mode is enabled
- allow users to set custom palette colors
- improve light variants and add `trve` mode
- improve light-variant selection backgrounds and Markdown link labels
- fix colorscheme switching, custom colors, and generated Ghostty, Foot, and Yazi themes
- add generated themes for Bat, Claude Code, Herdr, Lazygit, OpenCode, Pi, Starship, and Tmux

## 2.0 - 2025-05-04

- add alternate theme variants
- add Thyrfing and Windir themes
- allow loading colorschemes before calling `setup()`

## 1.1.0 - 2025-04-30

- add Ghostty themes

## 1.0.0 - 2025-04-22

- publish first Black Metal release, based on the Neomodern structure
- add initial band palettes, syntax and plugin highlights, and Lualine integration
- add generated themes for Alacritty, Fish, Fish Themes, Foot, Fzf, Kitty, WezTerm, Windows Terminal, and Yazi
- include terminal color support and an initial day palette
