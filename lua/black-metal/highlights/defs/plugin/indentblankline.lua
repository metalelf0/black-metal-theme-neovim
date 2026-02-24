local M = {}

M.get = function(palette, _, _)
    return {
        IndentBlanklineIndent1 = { guifg = palette.func },
        IndentBlanklineIndent2 = { guifg = palette.fg },
        IndentBlanklineIndent3 = { guifg = palette.keyword },
        IndentBlanklineIndent4 = { guifg = palette.comment },
        IndentBlanklineIndent5 = { guifg = palette.alt },
        IndentBlanklineIndent6 = { guifg = palette.operator },
        IndentBlanklineChar = { guifg = palette.comment, gui = "nocombine" },
        IndentBlanklineContextChar = { guifg = palette.comment, gui = "nocombine" },
        IndentBlanklineContextStart = { sp = palette.comment, gui = "underline" },
        IndentBlanklineContextSpaceChar = { gui = "nocombine" },
        IblIndent = { guifg = palette.comment, gui = "nocombine" },
        IblWhitespace = { guifg = palette.comment, gui = "nocombine" },
        IblScope = { guifg = palette.comment, gui = "nocombine" },
    }
end

return M
