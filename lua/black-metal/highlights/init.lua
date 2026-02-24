local M = {}
local lib = require("black-metal.highlights.lib")

---Dynamically loads all highlight definitions from defs/core/ and defs/plugin/.
---@param palette table { spec, base16 }
---@param opts table config options
---@return table<string, table>
local function load_defs(palette, opts)
    local source = debug.getinfo(1).source:sub(2)
    local hl_dir = vim.fn.fnamemodify(source, ":p:h")
    local subdirs = vim.fn.glob(string.format("%s/defs/*", hl_dir), false, true)
    local result = {}

    for _, subdir in ipairs(subdirs) do
        for _, fpath in ipairs(vim.fn.glob(string.format("%s/*.lua", subdir), false, true)) do
            result = vim.tbl_extend(
                "error",
                result,
                require(string.format(
                    "black-metal.highlights.defs.%s.%s",
                    vim.fn.fnamemodify(subdir, ":t"),
                    vim.fn.fnamemodify(fpath, ":t:r")
                )).get(palette.spec, palette.base16, opts)
            )
        end
    end

    return result
end

---Apply all highlight groups from config opts.
---@param opts table config options
function M.apply(opts)
    local palette = require("black-metal.palette").get(
        opts.theme,
        opts.background,
        opts.overrides and opts.overrides.default or {}
    )

    -- Apply legacy color overrides (opts.colors) to the spec
    if opts.colors then
        for label, color in pairs(opts.colors) do
            palette.spec[label] = color
        end
    end

    local highlights = load_defs(palette, opts)

    -- Apply overrides.hlgroups
    local hlgroups = opts.overrides and opts.overrides.hlgroups or {}
    for group, hl in pairs(highlights) do
        if hlgroups[group] ~= nil then
            hl = lib.overwrite(hl, hlgroups[group], palette.spec)
        end
        vim.api.nvim_command(lib.to_str(group, hl))
    end

    -- Apply legacy opts.highlights overrides
    if opts.highlights then
        for group, hi in pairs(opts.highlights) do
            local parts = {}
            if hi.fg then parts[#parts + 1] = lib.resolve_color("guifg", hi.fg, palette.spec) end
            if hi.bg then parts[#parts + 1] = lib.resolve_color("guibg", hi.bg, palette.spec) end
            if hi.sp then parts[#parts + 1] = lib.resolve_color("guisp", hi.sp, palette.spec) end
            if hi.fmt then parts[#parts + 1] = "gui=" .. hi.fmt end
            if #parts > 0 then
                vim.api.nvim_command(string.format("highlight %s %s", group, table.concat(parts, " ")))
            end
        end
    end

    if opts.favor_treesitter_hl then
        vim.highlight.priorities.semantic_tokens = 95
    end
end

return M
