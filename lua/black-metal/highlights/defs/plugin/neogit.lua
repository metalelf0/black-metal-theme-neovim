local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, _)
    local bg = palette.bg ~= "none" and palette.bg or "#000000"
    return {
        NeogitBranch                    = { guifg = palette.alt },
        NeogitUntrackedfiles            = { guifg = palette.diag_blue, gui = "italic" },
        NeogitUnpulledchanges           = { guifg = palette.diag_blue, gui = "italic" },
        NeogitUnmergedchanges           = { guifg = palette.keyword, gui = "bolditalic" },
        NeogitDiffAdd                   = { link = "DiffAdd" },
        NeogitDiffAddHighlight          = { link = "DiffAdd" },
        NeogitDiffAddCursor             = { guibg = Util.blend(palette.diag_green, 0.2, bg) },
        NeogitDiffDelete                = { link = "DiffDelete" },
        NeogitDiffDeleteHighlight       = { link = "DiffDelete" },
        NeogitDiffDeleteCursor          = { guibg = Util.blend(palette.diag_red, 0.2, bg) },
        NeogitDiffContext               = { guibg = palette.line },
        NeogitDiffContextHighlight      = { guibg = palette.line },
        NeogitDiffContextCursor         = { guibg = palette.line },
        NeogitSectionHeader             = { guifg = palette.func },
        NeogitHunkHeader                = { guifg = palette.comment },
        NeogitHunkHeaderHighlight       = { guifg = palette.comment, gui = "italic" },
        NeogitHunkHeaderCursor          = { guifg = palette.comment, gui = "bolditalic" },
        NeogitHunkMergeHeader           = { guifg = palette.diag_blue, guibg = palette.line, gui = "bold" },
        NeogitHunkMergeHeaderHighlight  = { guifg = palette.diag_blue, guibg = palette.line, gui = "italic" },
        NeogitHunkMergeHeaderCursor     = { guifg = palette.diag_blue, guibg = palette.line, gui = "bolditalic" },
    }
end

return M
