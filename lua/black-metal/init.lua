local M = {}
local Config = require("black-metal.config")

---@type black-metal.Config
local opts = Config.default
local __setup_called = false

---Returns a read-only copy of the current config.
---@return black-metal.Config
function M.options()
    return vim.deepcopy(opts)
end

---Toggle between light/dark variants.
function M.toggle_variant()
    if vim.o.background == "light" then
        vim.o.background = "dark"
        vim.api.nvim_command("colorscheme " .. opts.theme)
    else
        vim.api.nvim_command("colorscheme black-metal-day")
    end
end

---Apply the colorscheme (same as `:colorscheme <theme>`).
---@param theme string?
function M.load(theme)
    if theme then
        opts.theme = theme
    end
    -- Validate theme
    if require("black-metal.palette").themes[opts.theme] == nil then
        vim.schedule(function()
            vim.notify(
                string.format("black-metal.nvim: unknown theme '%s'", opts.theme),
                vim.log.levels.WARN
            )
        end)
        opts.theme = Config.default.theme
    end
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = opts.theme
    require("black-metal.highlights").apply(opts)
    require("black-metal.terminal").setup()
end

---Set the config options. Should be called before `load()`.
---@param cfg black-metal.Config?
function M.setup(cfg)
    if __setup_called then
        return
    end
    cfg = cfg or {}
    -- Backward compatibility: translate legacy boolean options to background string
    if cfg.alt_bg then
        cfg.background = "alt"
        cfg.alt_bg = nil
    end
    if cfg.transparent then
        cfg.background = "transparent"
        cfg.transparent = nil
    end
    -- Backward compatibility: translate legacy gutter options
    if cfg.cursorline_gutter ~= nil or cfg.dark_gutter ~= nil then
        cfg.gutter = cfg.gutter or {}
        if cfg.cursorline_gutter ~= nil then
            cfg.gutter.cursorline = cfg.cursorline_gutter
            cfg.cursorline_gutter = nil
        end
        if cfg.dark_gutter ~= nil then
            cfg.gutter.dark = cfg.dark_gutter
            cfg.dark_gutter = nil
        end
    end
    opts = vim.tbl_deep_extend("force", Config.default, cfg)
    if opts.toggle_variant_key then
        vim.keymap.set(
            "n",
            opts.toggle_variant_key,
            '<cmd>lua require("black-metal").toggle_variant()<cr>',
            { noremap = true, silent = true }
        )
    end
    __setup_called = true
end

return M
