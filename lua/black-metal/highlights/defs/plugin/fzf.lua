local M = {}

M.get = function(palette, _, _)
    return {
        FzfLuaBorder = { guifg = palette.operator },
        FzfLuaBufFlagCur = { guifg = palette.alt },
        FzfLuaBufFlagAlt = { guifg = palette.alt },
        FzfLuaTitleFlags = { guifg = palette.alt },
        FzfLuaHeaderText = { guifg = palette.alt },
        FzfLuaHeaderBind = { guifg = palette.number },
        FzfLuaLiveSym = { guifg = palette.type },
        FzfLuaLivePrompt = { guifg = palette.type },
        FzfLuaPathLineNr = { guifg = palette.alt },
        FzfLuaPathColNr = { guifg = palette.fg },
    }
end

return M
