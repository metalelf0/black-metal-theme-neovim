local M = {}

M.get = function(palette, _, _)
    return {
        NeoTreeNormal = { guifg = palette.fg, guibg = palette.bg },
        NeoTreeNormalNC = { guifg = palette.fg, guibg = palette.bg },
        NeoTreeVertSplit = { guifg = palette.comment, guibg = palette.bg },
        NeoTreeWinSeparator = { guifg = palette.comment, guibg = palette.bg },
        NeoTreeEndOfBuffer = { link = "EndOfBuffer" },
        NeoTreeRootName = { guifg = palette.type, gui = "bold" },
        NeoTreeGitAdded = { guifg = palette.fg },
        NeoTreeGitDeleted = { guifg = palette.diag_red },
        NeoTreeGitModified = { guifg = palette.diag_blue },
        NeoTreeGitConflict = { guifg = palette.diag_red, gui = "bold,italic" },
        NeoTreeGitUntracked = { guifg = palette.diag_red, gui = "italic" },
        NeoTreeIndentMarker = { guifg = palette.comment },
        NeoTreeSymbolicLinkTarget = { guifg = palette.diag_blue },
    }
end

return M
