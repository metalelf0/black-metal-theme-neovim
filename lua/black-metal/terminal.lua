local M = {}
local Util = require("black-metal.util")

---Returns the terminal colors associated with a theme, and optionally the entire
---palette.
---@param with_palette boolean include the theme's palette colors
---@return table
function M.colors(with_palette)
    ---@type black-metal.Config
    local Config = require("black-metal").options()
    return M.colors_for(Config.theme, Config.variant, Config.alt_bg, with_palette)
end

---Returns terminal colors for an explicit theme variant without changing editor state.
---@param theme string
---@param variant string
---@param alt_bg boolean?
---@param with_palette boolean?
---@return table
function M.colors_for(theme, variant, alt_bg, with_palette)
    local palette = require("black-metal.palette").get(theme, variant)
    if alt_bg then
        require("black-metal.palette").with_alt_bg(palette)
    end
    palette.dim = Util.blend(palette.bg, 0.9, "#000000")
    if with_palette then
        return vim.tbl_deep_extend("force", palette.colormap, palette)
    end
    return palette.colormap
end

---Sets the vim terminal colors if `term_colors` is set in `black-metal.Config`.
function M.setup()
    ---@type black-metal.Config
    local Config = require("black-metal").options()
    if not Config.term_colors then
        return
    end
    local colors = M.colors(false)
    vim.g.terminal_color_0 = colors.black
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_2 = colors.green
    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_5 = colors.purple
    vim.g.terminal_color_6 = colors.cyan
    vim.g.terminal_color_7 = colors.white
    vim.g.terminal_color_8 = colors.grey
    vim.g.terminal_color_9 = colors.orange
    vim.g.terminal_color_10 = colors.green
    vim.g.terminal_color_11 = colors.yellow
    vim.g.terminal_color_12 = colors.blue
    vim.g.terminal_color_13 = colors.magenta
    vim.g.terminal_color_14 = colors.cyan
    vim.g.terminal_color_15 = colors.white
end

return M
