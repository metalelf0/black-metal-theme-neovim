local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, opts)
    local cs = opts.code_style or {}
    return {
        Boolean      = { guifg = palette.number },
        Character    = { guifg = palette.string },
        Comment      = { guifg = palette.comment, gui = cs.comments },
        Constant     = { guifg = palette.constant },
        Delimiter    = { guifg = palette.fg },
        Float        = { guifg = palette.number },
        Function     = { guifg = palette.func, gui = cs.functions },
        Error        = { guifg = palette.diag_red },
        Exception    = { guifg = palette.diag_red },
        Identifier   = { guifg = palette.property, gui = cs.variables },
        Keyword      = { guifg = palette.keyword, gui = cs.keywords },
        Conditional  = { guifg = palette.keyword, gui = cs.conditionals },
        Number       = { guifg = palette.number },
        Operator     = { guifg = palette.operator, gui = cs.operators },
        PreProc      = { guifg = palette.string },
        Include      = { guifg = palette.constant, gui = cs.keywords },
        Macro        = { guifg = palette.number, gui = "italic" },
        Special      = { guifg = palette.type },
        SpecialChar  = { guifg = palette.keyword },
        Statement    = { guifg = palette.keyword, gui = "none" },
        String       = { guifg = palette.string, gui = cs.strings },
        Title        = { guifg = palette.keyword },
        Type         = { guifg = palette.type },
        Todo         = {
            guifg = Util.blend(palette.comment, 0.6, palette.fg),
            gui = "bolditalic",
        },
    }
end

return M
