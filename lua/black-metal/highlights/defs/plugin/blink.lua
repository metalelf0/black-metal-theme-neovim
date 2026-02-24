local M = {}

M.get = function(palette, _, opts)
    local plugin = opts.plugin or {}
    local cmp = plugin.cmp or {}
    local reverse = cmp.reverse and "reverse" or nil

    local hl = {
        BlinkCmpKind = { guifg = palette.comment, gui = reverse },
    }

    if not cmp.plain then
        local lsp_kind_colors = {
            Default       = palette.keyword,
            Array         = palette.keyword,
            Boolean       = palette.func,
            Class         = palette.type,
            Color         = palette.fg,
            Constant      = palette.constant,
            Constructor   = palette.constant,
            Enum          = palette.constant,
            EnumMember    = palette.property,
            Event         = palette.type,
            Field         = palette.property,
            File          = palette.fg,
            Folder        = palette.func,
            Function      = palette.func,
            Interface     = palette.constant,
            Key           = palette.keyword,
            Keyword       = palette.keyword,
            Method        = palette.func,
            Module        = palette.constant,
            Namespace     = palette.constant,
            Null          = palette.type,
            Number        = palette.func,
            Object        = palette.type,
            Operator      = palette.operator,
            Package       = palette.constant,
            Property      = palette.property,
            Reference     = palette.type,
            Snippet       = palette.type,
            String        = palette.string,
            Struct        = palette.keyword,
            Text          = palette.fg,
            TypeParameter = palette.type,
            Unit          = palette.fg,
            Value         = palette.fg,
            Variable      = palette.fg,
        }
        for kind, color in pairs(lsp_kind_colors) do
            hl["BlinkCmpKind" .. kind] = { guifg = color, gui = reverse }
        end
    end

    return hl
end

return M
