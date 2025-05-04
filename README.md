# Black Metal Neovim

![logo](https://github.com/user-attachments/assets/ea628526-a058-4aeb-832f-c99d36d508a0)

The definitive collection of black-metal inspired neovim colorschemes!

This new version is based on the great work done by @cdmill on https://github.com/cdmill/neomodern.nvim. Big hail to him!

If you want to support the project, buy a T-shirt with the logo on [printify](https://black-metal-neovim.printify.me/product/19851229/neovim-graphic-unisex-softstyle-t-shirt-alternative-style-for-music-lovers)!

## Included themes

Here are the included themes. Each band has a default theme (on the left) and an alternative variant (on the right).

### Bathory

![bathory-full](https://github.com/user-attachments/assets/504edd20-df33-4399-bb4a-1b203b8d6a64)

### Burzum

![burzum-full](https://github.com/user-attachments/assets/bfc67176-9c71-4ede-b99e-36048102140d)

### Dark Funeral

![dark-funeral-full](https://github.com/user-attachments/assets/79850c1c-f5ea-4fac-b6d5-e11e0a1db808)

### Darkthrone

![darkthrone-full](https://github.com/user-attachments/assets/25baf96c-85e5-4f84-ac40-39278c71d3f0)

### Emperor

![emperor-full](https://github.com/user-attachments/assets/e12d7afa-06ca-4ccb-881f-3d1d433f7b47)

### Gorgoroth

![gorgoroth-full](https://github.com/user-attachments/assets/4a0cc06f-8f3d-4414-a2e0-2ca1999e896d)

### Immortal

![immortal-full](https://github.com/user-attachments/assets/720931e6-d8d4-479d-986a-088c0937fd7f)

### Impaled Nazarene

![impaled-nazarene-full](https://github.com/user-attachments/assets/bd818bea-1cf1-4ef9-9687-775c2f7440b0)

### Khold

![khold-full](https://github.com/user-attachments/assets/78d95824-0ad7-4cdc-98ea-0d29bf56f798)

### Marduk

![marduk-full](https://github.com/user-attachments/assets/9dca9fea-7a70-490c-b2de-798dcfa8d3f4)

### Mayhem

![mayhem-full](https://github.com/user-attachments/assets/5ccc7621-97e3-4601-b5b8-c550b3dd7042)

### Nile 

![nile-full](https://github.com/user-attachments/assets/05b73f47-5bf5-479a-a940-3447fd9e1474)

### Taake

![taake-full](https://github.com/user-attachments/assets/96cfb452-e1ef-4fbb-8c2f-1bb8fc3177dc)

### Thyrfing

![thyrfing-full](https://github.com/user-attachments/assets/ab786221-3c18-48d1-9eff-b4412577ae7f)

### Venom

![venom-full](https://github.com/user-attachments/assets/bacd0404-cf31-4872-ad64-25066bd27a72)

### Windir

![windir-full](https://github.com/user-attachments/assets/7d584730-c8bb-42db-9f49-774a7db14aeb)

## Rationale

Each theme palette is a slight variation of the base one. I picked two accent colors from an album cover for each band. I also included an alternative variant for each album with a not-black background. 

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
      -- optional configuration here
    })
    require("black-metal").load()
  end,
}
```

## Configuration

There are 16 themes included, each with a dark, alternative and light variant. Yes, I know, light variants aren't `TRVE`. Just don't use them if you don't like them.
The light theme is used when `{ variant = "light" }` is passed to `setup(options)` or when `vim.o.background = "light"`.

If you are ok with the default config, just load themes with either `:colorscheme <band_name>` or `:colorscheme <band_name>-alt`. If you need further customization, here you go: 

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
  -- Override default colors
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


