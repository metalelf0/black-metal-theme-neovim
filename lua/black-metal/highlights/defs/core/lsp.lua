local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, _)
    return {
        ["@lsp.typemod.variable.global"] = {
            guifg = Util.blend(palette.constant, 0.8, palette.bg),
        },
        ["@lsp.typemod.keyword.documentation"] = {
            guifg = Util.blend(palette.type, 0.8, palette.bg),
        },
        ["@lsp.type.namespace"] = {
            guifg = Util.blend(palette.constant, 0.8, palette.bg),
        },
        ["@lsp.type.macro"] = { link = "Macro" },
        ["@lsp.type.parameter"] = { link = "@variable.parameter" },
        ["@lsp.type.lifetime"] = { guifg = palette.type, gui = "italic" },
        ["@lsp.type.readonly"] = {
            guifg = palette.constant,
            gui = "italic",
        },
        ["@lsp.mod.readonly"] = { guifg = palette.constant, gui = "italic" },
        ["@lsp.mod.typeHint"] = { link = "Type" },

        LspReferenceText = { guibg = palette.visual },
        LspReferenceWrite = { guibg = palette.visual },
        LspReferenceRead = { guibg = palette.visual },

        LspCodeLens = {
            guifg = palette.keyword,
            guibg = Util.blend(palette.keyword, 0.1, palette.bg),
        },
        LspCodeLensSeparator = { guifg = palette.comment },
    }
end

return M
