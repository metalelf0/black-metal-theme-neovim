local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, _)
    local bg = palette.bg ~= "none" and palette.bg or "#000000"
    return {
        ObsidianTodo          = { link = "@markup.list.unchecked" },
        ObsidianDone          = { link = "@markup.list.checked" },
        ObsidianRightArrow    = { guifg = palette.fg, gui = "bold" },
        ObsidianTilde         = { guifg = palette.fg, gui = "bold" },
        ObsidianBullet        = { link = "@markup.list" },
        ObsidianRefText       = { link = "@markup.link" },
        ObsidianExtLinkIcon   = { link = "@markup.strikethrough" },
        ObsidianTag           = { link = "@markup.list.unchecked" },
        ObsidianHighlightText = {
            guifg = palette.constant,
            guibg = Util.blend(palette.constant, 0.1, bg),
        },
    }
end

return M
