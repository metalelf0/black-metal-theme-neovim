local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, opts)
    local cs = opts.code_style or {}
    local colored_doc = opts.colored_docstrings ~= false

    return {
        -- identifiers
        ["@variable"]            = { guifg = palette.fg, gui = cs.variables },
        ["@variable.builtin"]    = { link = "Type" },
        ["@variable.member"]     = { guifg = palette.property },
        ["@variable.parameter"]  = { guifg = palette.alt },

        ["@constant.builtin"]    = { link = "Type" },
        ["@module"]              = { link = "Type" },

        -- literals
        ["@string.documentation"] = colored_doc and { link = "String" } or { link = "Comment" },
        ["@string.regexp"]       = { link = "SpecialChar" },
        ["@string.escape"]       = { link = "SpecialChar" },
        ["@string.special.symbol"] = { link = "String" },

        -- types
        ["@type"]                = { link = "Type" },
        ["@attribute"]           = { link = "Function" },

        -- functions
        ["@function"]            = { link = "Function" },
        ["@function.builtin"]    = { link = "Function" },
        ["@constructor.lua"]     = { guifg = palette.alt, gui = cs.functions },
        ["@operator"]            = { link = "Operator" },

        -- keywords
        ["@keyword"]             = { guifg = palette.keyword, gui = cs.keywords },
        ["@keyword.exception"]   = { link = "Exception" },
        ["@keyword.conditional"] = { guifg = palette.keyword, gui = cs.conditionals },
        ["@keyword.operator"]    = { guifg = palette.keyword, gui = cs.operators },
        ["@keyword.return"]      = { guifg = palette.keyword, gui = cs.keyword_return },

        -- punctuation
        ["@punctuation.delimiter"] = { guifg = palette.fg },
        ["@punctuation.bracket"]   = { guifg = palette.alt },
        ["@punctuation.special"]   = { link = "SpecialChar" },

        -- comments
        ["@comment.error"]   = { guifg = Util.blend(palette.comment, 0.4, palette.diag_red), gui = "bolditalic" },
        ["@comment.warning"] = { guifg = Util.blend(palette.comment, 0.4, palette.diag_yellow), gui = "bolditalic" },
        ["@comment.note"]    = { guifg = Util.blend(palette.comment, 0.4, palette.diag_blue), gui = "bolditalic" },

        -- markup
        ["@markup"]                   = { guifg = palette.fg },
        ["@markup.strong"]            = { guifg = palette.fg, gui = "bold" },
        ["@markup.italic"]            = { guifg = palette.fg, gui = "italic" },
        ["@markup.underline"]         = { guifg = palette.fg, gui = "underline" },
        ["@markup.strikethrough"]     = { guifg = palette.comment, gui = "strikethrough" },
        ["@markup.heading"]           = { guifg = palette.keyword, gui = cs.headings },
        ["@markup.quote.markdown"]    = { guifg = palette.comment },
        ["@markup.link.uri"]          = { guifg = palette.alt, gui = "underline" },
        ["@markup.link"]              = { guifg = palette.type },
        ["@markup.list"]              = { guifg = palette.func },
        ["@markup.list.checked"]      = { guifg = palette.func },
        ["@markup.list.unchecked"]    = { guifg = palette.func },
        ["@markup.raw"]               = { guifg = palette.func },
        ["@markup.math"]              = { guifg = palette.type },

        -- diff
        ["@diff.plus"]  = { guifg = palette.diag_green },
        ["@diff.minus"] = { guifg = palette.diag_red },
        ["@diff.delta"] = { guifg = palette.diag_blue },

        -- tags
        ["@tag.attribute"] = { link = "Identifier" },
        ["@tag.delimiter"] = { guifg = palette.fg },
    }
end

return M
