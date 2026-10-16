local M = {}

---@alias Highlight {fg:string, bg:string, sp:string, fmt:string}

---Process fmt string, removing underline/undercurl if config.underline false
---@param fmt string
---@param config black-metal.Config
---@return string
local function process_fmt(fmt, config)
	if type(fmt) ~= "string" then
		return "none"
	end
	if config.underline ~= false or fmt == "none" then
		return fmt
	end
	-- Remove underline and undercurl
	local parts = {}
	for part in fmt:gmatch("[^,%s]+") do
		if part ~= "underline" and part ~= "undercurl" then
			table.insert(parts, part)
		end
	end
	if #parts == 0 then
		return "none"
	end
	return table.concat(parts, ",")
end

---@param highlights table<string,Highlight>
local function vim_highlights(highlights, config)
	for group, hi in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group,
				hi.fg or "none",
				hi.bg or "none",
				hi.sp or "none",
				process_fmt(hi.fmt, config)
			)
		)
	end
end

---Util for applying custom user colors.
local function report_override_error(group, attribute, message)
	vim.schedule(function()
		vim.notify(
			("black-metal: invalid %s override for %s: %s"):format(attribute, group, message),
			vim.log.levels.ERROR,
			{ title = "black-metal.nvim" }
		)
	end)
end

local function valid_highlight_color(color)
	if type(color) ~= "string" then
		return false
	end
	if color == "none" or color == "fg" or color == "bg" then
		return true
	end
	if color:match("^#%x%x%x%x%x%x$") then
		return true
	end
	local ok, value = pcall(vim.api.nvim_get_color_by_name, color)
	return ok and value >= 0
end

---@param group string
---@param attribute string
---@param color string|fun(palette:black-metal.Theme, variant:string):string|nil
---@param palette black-metal.Theme
---@param variant string
---@param config black-metal.Config
local function overwrite(group, attribute, color, palette, variant, config)
	if not color then
		return ""
	end
	if type(color) == "function" then
		if attribute == "fmt" then
			report_override_error(group, attribute, "callbacks are supported only for fg, bg, and sp")
			return ""
		end
		local ok, result = pcall(color, vim.deepcopy(palette), variant)
		if not ok then
			report_override_error(group, attribute, result)
			return ""
		end
		color = result
		if not valid_highlight_color(color) then
			report_override_error(group, attribute, "callback must return a valid highlight color")
			return ""
		end
	elseif type(color) ~= "string" then
		report_override_error(group, attribute, "expected a string or callback")
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
	if attribute == "fmt" then
		color = process_fmt(color, config)
	end
	local prefix = ({ fg = "guifg", bg = "guibg", sp = "guisp", fmt = "gui" })[attribute]
	return prefix .. "=" .. color
end

function M.setup()
	---@type black-metal.Config
	local Config = require("black-metal").options()

	local c = require("black-metal.palette").get(Config.theme, Config.variant)

	local custom_colors = Config.colors

	for label, color in pairs(custom_colors) do
		if label ~= "dark" and label ~= "light" then
			c[label] = color
		end
	end
	for label, color in pairs(custom_colors[Config.variant] or {}) do
		c[label] = color
	end

	local COMMON = require("black-metal.highlights.common").get(c)
	local SYNTAX = require("black-metal.highlights.syntax").get(c)
	local PLUGIN = require("black-metal.highlights.plugin").get(c)

	vim_highlights(COMMON, Config)
	for _, group in pairs(SYNTAX) do
		vim_highlights(group, Config)
	end
	for _, group in pairs(PLUGIN) do
		vim_highlights(group, Config)
	end

	for group, hi in pairs(Config.highlights) do
		local attributes = {
			overwrite(group, "fg", hi.fg, c, Config.variant, Config),
			overwrite(group, "bg", hi.bg, c, Config.variant, Config),
			overwrite(group, "sp", hi.sp, c, Config.variant, Config),
			overwrite(group, "fmt", hi.fmt, c, Config.variant, Config),
		}
		local command = table.concat(attributes, " ")
		if command ~= "" then
			vim.api.nvim_command("highlight " .. group .. " " .. command)
		end
	end
	if Config.favor_treesitter_hl then
		vim.highlight.priorities.semantic_tokens = 95
	end
end

return M
