local M = {}

M.get = function(palette, _, _)
    return {
        DiffviewFilePanelTitle = { guifg = palette.func, gui = "bold" },
        DiffviewFilePanelCounter = { guifg = palette.alt, gui = "bold" },
        DiffviewFilePanelFileName = { guifg = palette.fg },
        DiffviewNormal = { link = "Normal" },
        DiffviewCursorLine = { link = "CursorLine" },
        DiffviewVertSplit = { link = "VertSplit" },
        DiffviewSignColumn = { link = "SignColumn" },
        DiffviewStatusLine = { link = "StatusLine" },
        DiffviewStatusLineNC = { link = "StatusLineNC" },
        DiffviewEndOfBuffer = { link = "EndOfBuffer" },
        DiffviewFilePanelRootPath = { guifg = palette.comment },
        DiffviewFilePanelPath = { guifg = palette.comment },
        DiffviewFilePanelInsertions = { guifg = palette.fg },
        DiffviewFilePanelDeletions = { guifg = palette.operator },
        DiffviewStatusAdded = { guifg = palette.fg },
        DiffviewStatusUntracked = { guifg = palette.diag_blue },
        DiffviewStatusModified = { guifg = palette.diag_blue },
        DiffviewStatusRenamed = { guifg = palette.diag_blue },
        DiffviewStatusCopied = { guifg = palette.diag_blue },
        DiffviewStatusTypeChange = { guifg = palette.diag_blue },
        DiffviewStatusUnmerged = { guifg = palette.diag_blue },
        DiffviewStatusUnknown = { guifg = palette.diag_red },
        DiffviewStatusDeleted = { guifg = palette.diag_red },
        DiffviewStatusBroken = { guifg = palette.diag_red },
    }
end

return M
