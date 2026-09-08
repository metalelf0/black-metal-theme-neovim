local Config = require("black-metal.config")
local M = {
	---@type black-metal.Config
	__opts = {},
	-- __setup_called = false,
}

---Returns a read-only copy of the config.
---@return black-metal.Config
function M.options()
	return vim.deepcopy(M.__opts)
end

---Toggle between light/dark variants.
function M.toggle_variant()
	if vim.o.background == "light" then
		vim.api.nvim_command("colorscheme " .. M.__opts.theme)
	else
		vim.api.nvim_command("colorscheme black-metal-light")
	end
end

---Apply the colorscheme (same as `:colorscheme black-metal`).
---@param theme string?
---@param variant string? 'light'|'dark'. If omitted, inferred from `black-metal.variant`
---(set via `setup(opts)`) or `vim.o.background`.
function M.load(theme, variant)
	M.__opts.theme = theme or M.__opts.theme
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true

	local resolved = variant
	if resolved == nil then
		if vim.o.background == "light" or M.__opts.variant == "light" then
			resolved = "light"
		else
			resolved = "dark"
		end
	end

	-- there is no light in trve black metal
	vim.print(vim.inspect(M.__opts.trve))
	if M.__opts.trve and resolved == "light" then
		vim.notify(
			"black-metal: `trve` is true (default), so light variants are disabled -- there is no light in trve black metal. Set `trve = false` to use them.",
			vim.log.levels.WARN
		)
		resolved = "dark"
	end

	M.__opts.variant = resolved

	-- Neovim automatically reloads the active colorscheme whenever
	-- 'background' changes while `g:colors_name` is set (see `:help
	-- 'background'`). Clear it first so assigning `vim.o.background` below
	-- doesn't recursively re-trigger this same colorscheme file.
	vim.g.colors_name = nil
	vim.o.background = resolved
	vim.g.colors_name = M.__opts.theme

	require("black-metal.highlights").setup()
	require("black-metal.terminal").setup()
end

---Set the config options.
---@param opts black-metal.Config
function M.setup(opts)
	-- if M.__setup_called then
	-- 	return
	-- end
	--
	opts = opts or {}

	-- `trve` is sticky across setup() calls. Every `colors/<name>.lua` file
	-- calls `setup({...})` fresh (without a `trve` key) when switching
	-- themes via `:colorscheme`, which would otherwise silently reset a
	-- user's `trve = false` back to the default `true` on every switch.
	local trve = M.__opts.trve
	if trve == nil then
		trve = Config.default.trve
	end
	if opts.trve ~= nil then
		trve = opts.trve
	end

	---@type black-metal.Config
	M.__opts = vim.tbl_deep_extend("force", Config.default, opts)
	M.__opts.trve = trve
	M.__theme = M.__opts.theme
	if M.__opts.toggle_variant_key then
		vim.keymap.set(
			"n",
			M.__opts.toggle_variant_key,
			'<cmd>lua require("black-metal").toggle_variant()<cr>',
			{ noremap = true, silent = true }
		)
	end
	-- M.__setup_called = true
end

return M
