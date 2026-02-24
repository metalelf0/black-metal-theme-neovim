local M = {}

M.get = function(palette, _, _)
    return {
        NvimTreeNormal = { guifg = palette.fg, guibg = palette.bg },
        NvimTreeVertSplit = { guifg = palette.line, guibg = palette.bg },
        NvimTreeEndOfBuffer = { link = "EndOfBuffer" },
        NvimTreeRootFolder = { guifg = palette.type, gui = "bold" },
        NvimTreeGitDirty = { guifg = palette.diag_blue },
        NvimTreeGitNew = { guifg = palette.fg },
        NvimTreeGitDeleted = { guifg = palette.diag_red },
        NvimTreeSpecialFile = { guifg = palette.diag_yellow, gui = "underline" },
        NvimTreeIndentMarker = { guifg = palette.fg },
        NvimTreeImageFile = { guifg = palette.visual },
        NvimTreeSymlink = { guifg = palette.diag_blue },
        NvimTreeFolderName = { guifg = palette.func },
    }
end

return M
