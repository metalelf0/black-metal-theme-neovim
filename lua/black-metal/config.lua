local M = {}

---@class black-metal.Config
---@field alt_bg? boolean If true, uses a darker alternate bg color
---@field colors? table Has string fields to override default colors
---@field colored_docstrings? boolean If true, highlights docstrings like strings instead like of comments
---@field code_style? table Has string values to determine code style. Field values can be the same as gui highlight values, e.g. 'bold', 'italic', 'none'
---@field cursorline_gutter? boolean If true, highlights {sign, fold}column the same as cursorline
---@field dark_gutter? boolean If true, highlights the gutter darker than the bg
---@field diagnostics? table { darker:bool, undercurl:bool, background:bool }
---@field favor_treesitter_hl? boolean if true favor treesitter highlights over semantic highlights
---@field highlights? table Has string fields to override default highlights
---@field plain_float? boolean If true, does not set background of floating windows. Recommend for when using floating windows with borders
---@field plugin? table Has table or string fields to determine appearnce of plugins. Current plugin options are 'lualine', 'cmp', and 'telescope'
---@field show_eob? boolean If true, highlights end-of-buffer tildes like comments
---@field theme? string Preferred theme
---@field term_colors? boolean If true, enables terminal colors
---@field toggle_variant_key? nil|string Keymap (normal mode) to toggle light/dark mode
---@field transparent? boolean If true, does not set background colors
---@field trve? boolean If true (default), light variants are disabled -- there is no light in trve black metal
---@field variant? string light | dark
M.default = {
    alt_bg = false,
    colored_docstrings = true,
    cursorline_gutter = true,
    dark_gutter = false,
    favor_treesitter_hl = false,
    plain_float = false,
    show_eob = true,
    term_colors = true,
    theme = "bathory",
    toggle_variant_key = nil,
    transparent = false,
    trve = true,
    variant = "dark",

    code_style = {
        comments = "italic",
        conditionals = "none",
        functions = "none",
        keywords = "none",
        headings = "bold",
        operators = "none",
        keyword_return = "none",
        strings = "none",
        variables = "none",
    },

    colors = {},

    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    },

    highlights = {},

    plugin = {
        lualine = {
            bold = true,
            plain = false,
        },
        cmp = {
            plain = false,
            reverse = false,
        },
    },
}

return M
