local M = {}
local Util = require("black-metal.util")

---Returns the terminal colors associated with the current theme.
---@param with_palette boolean include the full palette colors in the result
---@return table
function M.colors(with_palette)
    local Config = require("black-metal").options()
    local palette = require("black-metal.palette").get(Config.theme, Config.background)
    local spec = palette.spec
    spec.dim = Util.blend(spec.bg ~= "none" and spec.bg or "#000000", 0.9, "#000000")
    local colormap = palette.colormap
    if with_palette then
        return vim.tbl_deep_extend("force", colormap, spec)
    end
    return colormap
end

---Sets vim terminal colors if `term_colors` is enabled in config.
function M.setup()
    local Config = require("black-metal").options()
    if not Config.term_colors then
        return
    end
    local c = M.colors(false)
    vim.g.terminal_color_0 = c.black
    vim.g.terminal_color_1 = c.red
    vim.g.terminal_color_2 = c.green
    vim.g.terminal_color_3 = c.yellow
    vim.g.terminal_color_4 = c.blue
    vim.g.terminal_color_5 = c.purple
    vim.g.terminal_color_6 = c.cyan
    vim.g.terminal_color_7 = c.white
    vim.g.terminal_color_8 = c.grey
    vim.g.terminal_color_9 = c.orange
    vim.g.terminal_color_10 = c.green
    vim.g.terminal_color_11 = c.yellow
    vim.g.terminal_color_12 = c.blue
    vim.g.terminal_color_13 = c.magenta
    vim.g.terminal_color_14 = c.cyan
    vim.g.terminal_color_15 = c.white
end

return M
