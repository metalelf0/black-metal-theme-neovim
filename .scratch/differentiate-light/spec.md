# Differentiate light themes

## Problem Statement
Light variants of the 16 themes (base `<name>-light`, alt `<name>-light-alt`) look nearly identical. Base light shares one background, one ink color, one neutral set and grey syntax roles; only `string` and `type` differ. Several alt backgrounds are near-identical pale pinks or grey-mauves.

## Solution
Give each light theme its own identity from its two album accents, while staying paper-like (moderate boldness). Make "too similar" measurable with a headless check that gates the change.

## User Stories
1. As a user of `bathory-light`, I want a warm-tinted paper and ink, so that it feels different from `immortal-light`.
2. As a user of `immortal-light`, I want a cool slate tint, so that I can tell it from warm themes at a glance.
3. As a user, I want keywords, functions, constants and numbers tinted from the theme accents, so that code colors differ between themes.
4. As a user of a `-light-alt` theme, I want a clearly stronger tint than its base, so that alt means something.
5. As a user, I want any two light themes to be visibly distinct in base and in alt.
6. As a user, I want pickers, floats and cursorline to track the theme's background, so that nothing looks off-tint.
7. As a Darkthrone user, I want light to stay monochrome, so that its identity holds.
8. As a maintainer, I want a single command that fails when two themes are too close or contrast is too low, so that regressions are caught.
9. As a maintainer, I want `diag_*` shared, so that error/warn/info stay semantically consistent.
10. As a reader, I want body text, comments and accents to stay readable on every background.

## Implementation Decisions
- Light base `bg` and `line` become per-theme, a low-chroma tint of the theme hue (reverses the earlier shared-bg decision). Highlight code is unchanged: it reads `bg`/`line` from the palette, and alt already sets `bg`/`line` to `alt_bg`.
- Alt `alt_bg` stays a stronger tint of the same hue family as base `bg`.
- `fg`, `comment`, `visual` (and `property`, `alt`) are tinted slightly toward the theme hue. `diag_*` stay shared.
- `keyword`, `func`, `constant`, `number`, `operator` are muted tints derived from the theme's two accents.
- Boldness: moderate. Hue recognizable at a glance, chroma kept low for background.
- Darkthrone: neutral grey scale only; exempt from tinting; its alt is a no-op.
- Distinctness metric: perceptual distance (CIE Lab ΔE) over a fixed color signature per theme (bg, fg, comment, visual, keyword, func, constant, number, string, type), averaged; plus background-only ΔE. Computed pairwise for base and alt separately.
- Contrast metric: WCAG ratios of fg, comment, string, type, keyword, func against bg for base and alt.
- Thresholds are set from measured values on the final palettes and committed in the script.

## Testing Decisions
- Test external behavior only: loaded palette values per theme and variant.
- One seam: the palette module's light output for each theme, checked by a headless Neovim script.
- Prior art: the previous session's ad-hoc contrast script (not committed).

## Out of Scope
- Dark variants, plugin highlight code, terminal extras generation, new themes, a third accent per theme.

## Further Notes
- Fallback if gate cannot pass: add a hand-picked third accent per theme (Q3c).
