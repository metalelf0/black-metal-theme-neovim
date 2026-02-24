local M = {}

M.get = function(palette, _, _)
    return {
        TelescopeTitle = { guifg = palette.comment },
        TelescopeBorder = { guifg = palette.comment },
        TelescopeMatching = { guifg = palette.type, gui = "bold" },
        TelescopePromptPrefix = { guifg = palette.type },
        TelescopeSelection = {
            guifg = palette.diag_blue,
            guibg = palette.bg,
        },
        TelescopeSelectionCaret = { guifg = palette.diag_blue },
        TelescopeResultsNormal = { guifg = palette.fg },
    }
end

return M
