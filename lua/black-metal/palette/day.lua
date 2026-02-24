local M = {}

---Returns a light-mode variant of the given theme by inverting its colors.
---@param theme string? theme name (defaults to current colorscheme)
---@return table flat palette table
M.get = function(theme)
    theme = theme or vim.g.colors_name
    local Util = require("black-metal.util")
    local raw = require("black-metal.palette." .. theme)
    return Util.generate_light_variant(vim.deepcopy(raw))
end

return M
