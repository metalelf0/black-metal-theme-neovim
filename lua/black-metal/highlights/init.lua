local M = {}

---@alias Highlight {fg:string, bg:string, sp:string, fmt:string}

---@param highlights table<string,Highlight>
local function vim_highlights(highlights)
	for group, hi in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group,
				hi.fg or "none",
				hi.bg or "none",
				hi.sp or "none",
				hi.fmt or "none"
			)
		)
	end
end

---Util for applying custom user colors.
---@param prefix string
---@param color string
---@param palette black-metal.Theme
---@return string
local function overwrite(prefix, color, palette)
	if not color then
		return ""
	end
	if color:sub(1, 1) == "$" then
		local name = color:sub(2, -1)
		color = palette[name]
		if not color then
			vim.schedule(function()
				vim.notify(
					'black-metal.nvim: unknown color "' .. name .. '"',
					vim.log.levels.ERROR,
					{ title = "black-metal.nvim" }
				)
			end)
			return ""
		end
	end
	return prefix .. "=" .. color
end

function M.setup()
	---@type black-metal.Config
	local Config = require("black-metal").options()

	local c = require("black-metal.palette").get(Config.theme, Config.variant)

	local custom_colors = Config.colors

	for label, color in pairs(custom_colors) do
		c[label] = color
	end

	local COMMON = require("black-metal.highlights.common").get(c)
	local SYNTAX = require("black-metal.highlights.syntax").get(c)
	local PLUGIN = require("black-metal.highlights.plugin").get(c)

	vim_highlights(COMMON)
	for _, group in pairs(SYNTAX) do
		vim_highlights(group)
	end
	for _, group in pairs(PLUGIN) do
		vim_highlights(group)
	end

	for group, hi in pairs(Config.highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s %s %s %s %s",
				group,
				overwrite("guifg", hi.fg, c),
				overwrite("guibg", hi.bg, c),
				overwrite("guisp", hi.sp, c),
				overwrite("gui", hi.fmt, c)
			)
		)
	end
	if Config.favor_treesitter_hl then
		vim.highlight.priorities.semantic_tokens = 95
	end
end

return M
