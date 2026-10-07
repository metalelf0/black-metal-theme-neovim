# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## v2.2.0 - 2026-10-07

- redesign light variants: every theme now has its own tinted background, ink, comment and selection colors, and syntax colors derived from its accents, so light themes are clearly different from each other
- add `<band_name>-light` and `<band_name>-light-alt` colorschemes for all themes
- fix pickers, floats and the cursor line using a white background in light variants
- give inline code and fenced code blocks a background, including for render-markdown.nvim and touchup.nvim
- color markdown headings per level (H1 to H6)
- fix markdown link label background being near-black in light variants
- keep options passed to `setup()` when switching themes with `:colorscheme`, instead of resetting them to defaults
- allow `colors.dark` and `colors.light` sub-tables to override colors for a single variant
- fix crash when underline styling is disabled
- add `scripts/check-light.lua` to check light palettes for distinctness and contrast

## v2.1.0 - 2026-09-21

- add configuration for disabling underline and undercurl styles
- make FloatBorder transparent when transparent mode is enabled

## v2.0.0 - 2026-01-27

- add new theme: MOON
- simplify config and public api

## v1.0.0 - 2025-04-16

### Changes

- add support for dark/light variants
- add new themes: GYOKURO and HOJICHA
- remove support for COFFEECAT, DARKFOREST, DAYLIGHT
- remove support for telescope appearance options
