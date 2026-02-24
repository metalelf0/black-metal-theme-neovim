local M = {}
local Util = require("black-metal.util")

M.get = function(palette, _, opts)
    return {
        DiagnosticError = { guifg = palette.diag_red },
        DiagnosticHint = { guifg = palette.diag_blue },
        DiagnosticInfo = { guifg = palette.diag_blue, gui = "italic" },
        DiagnosticWarn = { guifg = palette.diag_yellow },

        DiagnosticVirtualTextError = {
            guibg = opts.diagnostics.background
                    and Util.blend(palette.diag_red, 0.1, palette.bg)
                or nil,
            guifg = palette.diag_red,
        },
        DiagnosticVirtualTextWarn = {
            guibg = opts.diagnostics.background
                    and Util.blend(palette.diag_yellow, 0.1, palette.bg)
                or nil,
            guifg = palette.diag_yellow,
        },
        DiagnosticVirtualTextInfo = {
            guibg = opts.diagnostics.background
                    and Util.blend(palette.diag_blue, 0.1, palette.bg)
                or nil,
            guifg = palette.diag_blue,
        },
        DiagnosticVirtualTextHint = {
            guibg = opts.diagnostics.background
                    and Util.blend(palette.diag_blue, 0.1, palette.bg)
                or nil,
            guifg = palette.diag_blue,
        },

        DiagnosticUnderlineError = {
            gui = opts.diagnostics.undercurl and "undercurl" or "underline",
            guisp = palette.diag_red,
        },
        DiagnosticUnderlineHint = {
            gui = opts.diagnostics.undercurl and "undercurl" or "underline",
            guisp = palette.diag_blue,
        },
        DiagnosticUnderlineInfo = {
            gui = opts.diagnostics.undercurl and "undercurl" or "underline",
            guisp = palette.diag_blue,
        },
        DiagnosticUnderlineWarn = {
            gui = opts.diagnostics.undercurl and "undercurl" or "underline",
            guisp = palette.diag_yellow,
        },
    }
end

return M
