local M = {}

---@class black-metal.Config
---@field theme? string Preferred theme (default: "bathory")
---@field background? string "default" | "alt" | "transparent"
---@field gutter? { cursorline: boolean, dark: boolean }
---@field diagnostics? { darker: boolean, undercurl: boolean, background: boolean }
---@field overrides? { default: table, hlgroups: table }
---@field code_style? table Code style options (italic, bold, etc.)
---@field colored_docstrings? boolean Highlight docstrings like strings instead of comments
---@field favor_treesitter_hl? boolean Favor treesitter highlights over semantic highlights
---@field show_eob? boolean Highlight end-of-buffer tildes like comments
---@field term_colors? boolean Enable terminal colors
---@field toggle_variant_key? string|nil Keymap (normal mode) to toggle light/dark mode
---@field plain_float? boolean Do not set background of floating windows
---@field colors? table Override default palette colors
---@field highlights? table Override default highlight groups
---@field plugin? table Plugin-specific appearance options

M.default = {
    theme = "bathory",
    background = "default", -- "default" | "alt" | "transparent"

    gutter = {
        cursorline = true,
        dark = false,
    },

    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    },

    overrides = {
        default = {},
        hlgroups = {},
    },

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

    colored_docstrings = true,
    favor_treesitter_hl = false,
    show_eob = true,
    term_colors = true,
    toggle_variant_key = nil,
    plain_float = false,

    -- Additional color and highlight overrides (legacy API, prefer overrides.*)
    colors = {},
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
