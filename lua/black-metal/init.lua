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
		vim.o.background = "dark"
		vim.api.nvim_command("colorscheme " .. M.__opts.theme)
	else
		vim.api.nvim_command("colorscheme black-metal-day")
	end
end

---Apply the colorscheme (same as `:colorscheme black-metal`).
---@param theme string?
function M.load(theme)
	M.__opts.theme = theme or M.__opts.theme
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = M.__opts.theme
	if vim.o.background == "light" then
		M.__opts.variant = "light"
	else
		M.__opts.variant = "dark"
	end
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
	---@type black-metal.Config
	M.__opts = vim.tbl_deep_extend("force", Config.default, opts or {})
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
