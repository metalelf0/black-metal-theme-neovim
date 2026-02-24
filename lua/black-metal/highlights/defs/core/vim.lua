local M = {}
local Util = require("black-metal.util")

M.get = function(palette, base16, opts)
    local transparent = opts.background == "transparent"
    local plain_float = opts.plain_float
    local show_eob = opts.show_eob ~= false
    local gutter = opts.gutter or {}
    local darkgutter = Util.darken(palette.bg ~= "none" and palette.bg or "#000000", 0.15)

    return {
        ColorColumn    = { guibg = palette.line },
        Conceal        = { guifg = palette.func, guibg = transparent and "none" or palette.bg },
        CurSearch      = { guifg = palette.type, guibg = palette.visual },
        Cursor         = { gui = "reverse" },
        vCursor        = { gui = "reverse" },
        iCursor        = { gui = "reverse" },
        lCursor        = { gui = "reverse" },
        CursorIM       = { gui = "reverse" },
        CursorColumn   = { guibg = palette.line },
        CursorLine     = { guibg = palette.line },
        CursorLineNr   = {
            guifg = palette.fg,
            guibg = (gutter.cursorline and palette.line or nil)
                or (gutter.dark and darkgutter or nil)
                or palette.bg,
        },
        CursorLineSign = { guibg = gutter.cursorline and palette.line or "none" },
        CursorLineFold = {
            guifg = palette.fg,
            guibg = gutter.cursorline and palette.line or "none",
        },
        Debug          = { guifg = palette.operator },
        debugPC        = { guifg = palette.diag_red },
        debugBreakpoint = { guifg = palette.diag_red },
        DiffAdd        = { guibg = Util.blend(palette.diag_green, 0.3, palette.bg ~= "none" and palette.bg or "#000000") },
        DiffChange     = { guibg = Util.blend(palette.diag_blue, 0.2, palette.bg ~= "none" and palette.bg or "#000000") },
        DiffDelete     = { guibg = Util.blend(palette.diag_red, 0.4, palette.bg ~= "none" and palette.bg or "#000000") },
        DiffText       = {
            guifg = palette.diag_blue,
            guibg = Util.blend(palette.diag_blue, 0.1, palette.bg ~= "none" and palette.bg or "#000000"),
        },
        Directory      = { guifg = base16.blue or palette.func },
        ErrorMsg       = { guifg = palette.diag_red, gui = "bold" },
        EndOfBuffer    = { guifg = show_eob and palette.comment or palette.bg },
        FloatBorder    = { guifg = palette.operator, guibg = plain_float and "none" or palette.bg },
        FloatTitle     = { guifg = palette.comment, guibg = plain_float and "none" or palette.line },
        Folded         = { guifg = palette.comment, guibg = transparent and "none" or palette.line },
        FoldColumn     = {
            guifg = palette.comment,
            guibg = (transparent and "none" or nil)
                or (gutter.dark and darkgutter or nil)
                or palette.bg,
        },
        IncSearch      = { guifg = palette.type, guibg = palette.visual },
        LineNr         = {
            guifg = palette.comment,
            guibg = (transparent and "none" or nil)
                or (gutter.dark and darkgutter or nil)
                or palette.bg,
        },
        MatchParen     = { guifg = palette.fg, guibg = palette.visual, gui = "bold" },
        ModeMsg        = { guifg = palette.fg, gui = "bold" },
        MoreMsg        = { guifg = palette.func, gui = "bold" },
        MsgSeparator   = { guifg = palette.string, guibg = palette.line, gui = "bold" },
        NonText        = { guifg = palette.comment },
        Normal         = { guifg = palette.fg, guibg = transparent and "none" or palette.bg },
        NormalFloat    = {
            guifg = palette.fg,
            guibg = (transparent or plain_float) and "none" or palette.line,
        },
        Pmenu          = { guifg = palette.comment, guibg = transparent and "none" or palette.bg, gui = "none" },
        PmenuSbar      = { guibg = palette.line },
        PmenuSel       = {
            guifg = palette.alt,
            guibg = transparent and "none" or palette.line,
            gui = "none",
        },
        PmenuThumb     = { guibg = palette.visual },
        Question       = { guifg = palette.constant },
        QuickFixLine   = { guifg = palette.func, gui = "underline" },
        Search         = { guifg = palette.alt, guibg = palette.visual },
        SignColumn     = {
            guifg = palette.fg,
            guibg = (transparent and "none" or nil)
                or (gutter.dark and darkgutter or nil)
                or palette.bg,
        },
        SpecialKey     = { guifg = palette.comment },
        SpellBad       = { guifg = "none", gui = "undercurl", guisp = palette.diag_red },
        SpellCap       = { guifg = "none", gui = "undercurl", guisp = palette.diag_yellow },
        SpellLocal     = { guifg = "none", gui = "undercurl", guisp = palette.diag_blue },
        SpellRare      = { guifg = "none", gui = "undercurl", guisp = palette.diag_blue },
        StatusLine     = { guifg = palette.comment, guibg = palette.line },
        StatusLineTerm = { guifg = palette.comment, guibg = palette.line },
        StatusLineNC   = { guifg = palette.comment, guibg = palette.line },
        StatusLineTermNC = { guifg = palette.comment, guibg = palette.line },
        Substitute     = { guifg = palette.type, guibg = palette.visual },
        TabLine        = { guifg = palette.comment, guibg = palette.line },
        TabLineFill    = { guifg = palette.comment, guibg = palette.line },
        TabLineSel     = { guifg = palette.alt, guibg = palette.visual },
        Terminal       = { guifg = palette.fg, guibg = transparent and "none" or palette.bg },
        ToolbarButton  = { guifg = palette.bg, guibg = palette.visual },
        ToolbarLine    = { guifg = palette.fg },
        Visual         = { guifg = palette.alt, guibg = palette.visual },
        VisualNOS      = { guifg = "none", guibg = palette.comment, gui = "underline" },
        WarningMsg     = { guifg = palette.diag_yellow, gui = "bold" },
        Whitespace     = { guifg = palette.comment },
        WildMenu       = {
            guifg = palette.alt,
            guibg = Util.blend(palette.diag_blue, 0.1, palette.bg ~= "none" and palette.bg or "#000000"),
        },
        WinSeparator   = { guifg = palette.operator },

        healthSectionDelim = { guifg = palette.keyword, guibg = palette.line },
    }
end

return M
