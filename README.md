# Black Metal Neovim

![logo](https://github.com/user-attachments/assets/ea628526-a058-4aeb-832f-c99d36d508a0)

The definitive collection of black-metal inspired neovim colorschemes!

This new version is based on the great work done by @cdmill on https://github.com/cdmill/neomodern.nvim. Big hail to him!

If you want to support the project, buy a T-shirt with the logo on [printify](https://black-metal-neovim.printify.me/product/19851229/neovim-graphic-unisex-softstyle-t-shirt-alternative-style-for-music-lovers)!

## Included themes

Here are the included themes. Each band has a default theme (on the left) and an alternative variant (on the right).

If you want a better view of the previews, look [in the wiki](https://github.com/metalelf0/black-metal-theme-neovim/wiki/Theme-previews).

### Bathory

<img width="3792" height="2236" alt="bathory-full" src="https://github.com/user-attachments/assets/5fe6b215-bde7-40b4-84a4-aca3675ebe3e" />


### Burzum

<img width="3792" height="2236" alt="burzum-full" src="https://github.com/user-attachments/assets/a2d3c794-1968-46d4-8154-e19fcac59bd1" />

### Dark Funeral

<img width="3792" height="2236" alt="dark-funeral-full" src="https://github.com/user-attachments/assets/182a65e5-b68e-4a58-9cdd-97ecc84d29ad" />

### Darkthrone

<img width="3792" height="2236" alt="darkthrone-full" src="https://github.com/user-attachments/assets/d63515d2-ee49-4b45-b376-f91ab8b27298" />

### Emperor

<img width="3792" height="2236" alt="emperor-full" src="https://github.com/user-attachments/assets/4be8df8a-6c12-4747-9c43-807e592343c4" />

### Gorgoroth

<img width="3792" height="2236" alt="gorgoroth-full" src="https://github.com/user-attachments/assets/078166e7-3ac9-4bad-9d22-03860bf72ace" />

### Immortal

<img width="3792" height="2236" alt="immortal-full" src="https://github.com/user-attachments/assets/e863f591-9d8d-450d-8ff6-9daa7e3fa300" />

### Impaled Nazarene

<img width="3792" height="2236" alt="impaled-nazarene-full" src="https://github.com/user-attachments/assets/d4031f6e-57fe-485d-a70e-e792e325d2ca" />

### Khold

<img width="3792" height="2236" alt="khold-full" src="https://github.com/user-attachments/assets/3c865585-c01f-42f1-8ad9-697330603858" />

### Marduk

<img width="3792" height="2236" alt="marduk-full" src="https://github.com/user-attachments/assets/d47aa2e8-a5f7-4885-a40d-efeafc2a1850" />

### Mayhem

<img width="3792" height="2236" alt="mayhem-full" src="https://github.com/user-attachments/assets/77928f3f-28fe-42f7-b71c-0f8d02311d20" />

### Nile 

<img width="3792" height="2236" alt="nile-full" src="https://github.com/user-attachments/assets/05be0d13-d627-4ca4-8da4-5d216357e1c6" />

### Taake

<img width="3792" height="2236" alt="taake-full" src="https://github.com/user-attachments/assets/271a6405-797e-45b2-8d84-76e023b9afb3" />

### Thyrfing

<img width="3792" height="2236" alt="thyrfing-full" src="https://github.com/user-attachments/assets/1892259b-2a4c-4f23-bdef-b5dd27d33cfd" />

### Venom

<img width="3792" height="2236" alt="venom-full" src="https://github.com/user-attachments/assets/437f89e3-aaa5-4d30-a797-ada55ccd8c78" />

### Windir

<img width="3792" height="2236" alt="windir-full" src="https://github.com/user-attachments/assets/b8b7d58f-9023-43aa-a34a-a838fc7f679d" />

## Rationale

Each theme palette is a slight variation of the base one. I picked two accent colors from an album cover for each band. I also included an alternative variant for each album with a not-black background. 

### Light variants

Every theme also has a hand-tuned light variant (`<band_name>-light`) and a light alternative (`<band_name>-light-alt`). Light palettes are not an inverted copy of the dark ones: each band gets its own tinted paper background, matching ink, comment and selection colors, and syntax colors derived from its two album accents. Inside each light variant, floats, pickers and the cursor line follow the theme background. Darkthrone stays monochrome. Light palettes are checked for distinctness and contrast with `scripts/check-light.lua`.

## Installation

With lazy.nvim:

```lua
-- Using lazy.nvim
{
  "metalelf0/black-metal-theme-neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require("black-metal").setup({
      -- optional configuration here, e.g.:
      trve = true, -- switch this to false if you want light variants
    })
    require("black-metal").load()
  end,
}
```

## Configuration

There are 16 themes included, each with a dark, alternative, light and light alternative variant. Check light palettes for distinctness and contrast with `nvim --headless --clean -u NONE -l scripts/check-light.lua`.

Yes, I know, light variants aren't `TRVE`. There is no light in trve black metal, so light variants are disabled by default -- pass `{ trve = false }` to `setup(options)` if you insist on using them.
The light theme is used when `{ variant = "light" }` is passed to `setup(options)` or when `vim.o.background = "light"` (and `trve = false`).

If you are ok with the default config, just load themes with `:colorscheme <band_name>`, `:colorscheme <band_name>-alt`, `:colorscheme <band_name>-light` (light), or `:colorscheme <band_name>-light-alt` (light, alternative bg). If you need further customization, here you go: 

Default options are given below:

```lua
require("black-metal").setup({
  -----MAIN OPTIONS-----
  --
  -- Can be one of: bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
  theme = "bathory",
  -- Can be one of: 'light' | 'dark', or set via vim.o.background
  variant = "dark",
  -- Use an alternate, lighter bg
  alt_bg = false,
  -- If true, docstrings will be highlighted like strings, otherwise they will be
  -- highlighted like comments. Note, behavior is dependent on the language server.
  colored_docstrings = true,
  -- If true, highlights the {sign,fold} column the same as cursorline
  cursorline_gutter = true,
  -- If true, highlights the gutter darker than the bg
  dark_gutter = false,
  -- if true favor treesitter highlights over semantic highlights
  favor_treesitter_hl = false,
  -- Don't set background of floating windows. Recommended for when using floating
  -- windows with borders.
  plain_float = false,
  -- Show the end-of-buffer character
  show_eob = true,
  -- If true, enable the vim terminal colors
  term_colors = true,
  -- Keymap (in normal mode) to toggle between light and dark variants.
  toggle_variant_key = nil,
  -- Don't set background
  transparent = false,
  -- There is no light in trve black metal: if true, light variants are disabled
  -- and loading one falls back to dark. Set to false to allow light variants.
  trve = true,

  -----DIAGNOSTICS and CODE STYLE-----
  --
  diagnostics = {
    darker = true, -- Darker colors for diagnostic
    undercurl = true, -- Use undercurl for diagnostics
    background = true, -- Use background color for virtual text
  },
  -- The following table accepts values the same as the `gui` option for normal
  -- highlights. For example, `bold`, `italic`, `underline`, `none`.
  code_style = {
    comments = "italic",
    conditionals = "none",
    functions = "none",
    keywords = "none",
    headings = "bold", -- Markdown headings
    operators = "none",
    keyword_return = "none",
    strings = "none",
    variables = "none",
  },

  -----PLUGINS-----
  --
  -- The following options allow for more control over some plugin appearances.
  plugin = {
    lualine = {
      -- Bold lualine_a sections
      bold = true,
      -- Don't set section/component backgrounds. Recommended to not set
      -- section/component separators.
      plain = false,
    },
    cmp = { -- works for nvim.cmp and blink.nvim
      -- Don't highlight lsp-kind items. Only the current selection will be highlighted.
      plain = false,
      -- Reverse lsp-kind items' highlights in blink/cmp menu.
      reverse = false,
    },
  },

  -- CUSTOM HIGHLIGHTS --
  --
  -- Override default colors. Top-level keys apply to every variant; use the
  -- `dark` / `light` sub-tables to override a single variant, e.g.
  -- colors = { dark = { fg = "#f1f1f1" }, light = { fg = "#101010" } }
  colors = {},
  -- Override highlight groups
  highlights = {},
})
-- Convenience function that simply calls `:colorscheme <theme>` with the theme
-- specified in your config.
require("black-metal").load()
```

## Customization

Example using custom colors and highlights:

```lua
require("black-metal").setup {
  colors = {
    orange = '#ff8800', -- define a new color
    keyword = '#817faf', -- redefine an existing color
  },
  highlights = {
    ...
    ["@keyword"] = { fg = "$keyword", fmt = 'bold' },
    ["@function"] = { bg = "$orange", fmt = 'underline,italic' },
    ...
  },
}
```

See `black-metal.palette` for color names.

## Extras

Theme files are generated for:

- Alacritty
- Bat
- Claude Code
- Eza
- Fish
- Foot
- Fzf
- Ghostty
- Herdr
- Kitty
- Lazygit
- Opencode
- Pi
- Starship
- Tmux
- WezTerm
- Windows Terminal
- Yazi

Files are available under `extras/<tool>`. Regenerate them from Neovim with:

```vim
:lua require("black-metal.extras").setup()
```

## Cover references

- Bathory: Hammerheart, 1990
- Burzum: Filosofem, 1996
- Dark Funeral: The secrets of the black arts, 1996
- Darkthrone: Transilvanian Hunger, 1994
- Emperor: In the nightside eclipse, 1994
- Gorgoroth: Twilight of the Idols - In Conspiracy with Satan, 2003
- Immortal: At the heart of winter, 1999
- Impaled Nazarene: Tol Cormpt Norz Norz Norz..., 1993
- Khold: Phantom, 2002
- Marduk: Panzer Division Marduk, 1999
- Mayhem: The dawn of the black hearts, 1995
- Nile: Black seeds of vengeance, 2000
- Taake:  Hordalands doedskvad, 2005
- Thyrfing: Valdr Galga, 1999
- Venom: Welcome to hell, 1981
- Windir: Arntor, 1999

## Disclaimers

- I know Nile don't play black metal, but I don't want to name the repo 'Black Metal and Technical Death Metal' ;).
- Darkthrone don't have an alternative variant. Bear with it. It's Transilvanian Hunger. Black and white, no need for any other color.
- Bands and album choices have been made completely on personal taste. If your fave band is missing, just ask and I'll try adding it.
