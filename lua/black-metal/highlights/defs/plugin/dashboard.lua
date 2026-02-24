local M = {}

M.get = function(palette, _, _)
    return {
        DashboardShortCut  = { guifg = palette.func },
        DashboardHeader    = { guifg = palette.keyword },
        DashboardCenter    = { guifg = palette.fg },
        DashboardFooter    = { guifg = palette.func, gui = "italic" },
        MiniStarterHeader  = { guifg = palette.keyword },
        MiniStarterFooter  = { guifg = palette.keyword },
        LazyNormal         = { guibg = palette.line },
        MasonNormal        = { guibg = palette.line },
        BufferLineBufferSelected = { guifg = palette.string },
    }
end

return M
