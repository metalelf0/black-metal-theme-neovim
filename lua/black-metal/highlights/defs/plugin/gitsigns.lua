local M = {}

M.get = function(palette, _, _)
    return {
        GitSignsAdd = { guifg = palette.diag_green },
        GitSignsAddLn = { guifg = palette.diag_green },
        GitSignsAddNr = { guifg = palette.diag_green },
        GitSignsAddCul = { guifg = palette.diag_green, guibg = palette.line },
        GitSignsChange = { guifg = palette.diag_blue },
        GitSignsChangeLn = { guifg = palette.diag_blue },
        GitSignsChangeNr = { guifg = palette.diag_blue },
        GitSignsChangeCul = { guifg = palette.diag_blue, guibg = palette.line },
        GitSignsDelete = { guifg = palette.diag_red },
        GitSignsDeleteLn = { guifg = palette.diag_red },
        GitSignsDeleteNr = { guifg = palette.diag_red },
        GitSignsDeleteCul = { guifg = palette.diag_red, guibg = palette.line },
    }
end

return M
