local M = {}

M.get = function(palette, _, _)
    return {
        SnacksDashboardIcon    = { guifg = palette.func },
        SnacksDashboardDesc    = { guifg = palette.func },
        SnacksDashboardFile    = { guifg = palette.alt },
        SnacksDashboardSpecial = { guifg = palette.type },
    }
end

return M
