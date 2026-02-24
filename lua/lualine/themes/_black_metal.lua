local M = {}

function M.get()
	---@type black-metal.Config
	local Config = require("black-metal").options()
	local colors = require("black-metal.terminal").colors(true)
	local c = {
		norm = colors.blue,
		ins = colors.yellow,
		vis = colors.purple,
		rep = colors.cyan,
		comm = colors.orange,
		fg_dim = colors.comment,
		vcs = colors.alt,
		bg_b = colors.visual,
		bg_c = colors.line,
		dark = colors.bg,
		none = "none",
	}

	local hl = {}

	hl.normal = {
		a = {
			bg = Config.plugin.lualine.plain and c.none or c.norm,
			fg = Config.plugin.lualine.plain and c.norm or c.dark,
			gui = Config.plugin.lualine.bold and "bold" or c.none,
		},
		b = { bg = Config.plugin.lualine.plain and c.none or c.bg_b, fg = c.vcs },
		c = { bg = Config.plugin.lualine.plain and c.none or c.bg_c, fg = c.fg_dim },
	}

	hl.insert = {
		a = {
			bg = Config.plugin.lualine.plain and c.none or c.ins,
			fg = Config.plugin.lualine.plain and c.ins or c.dark,
			gui = Config.plugin.lualine.bold and "bold" or c.none,
		},
	}

	hl.visual = {
		a = {
			bg = Config.plugin.lualine.plain and c.none or c.vis,
			fg = Config.plugin.lualine.plain and c.vis or c.dark,
			gui = Config.plugin.lualine.bold and "bold" or c.none,
		},
	}

	hl.replace = {
		a = {
			bg = Config.plugin.lualine.plain and c.none or c.rep,
			fg = Config.plugin.lualine.plain and c.rep or c.dark,
			gui = Config.plugin.lualine.bold and "bold" or c.none,
		},
	}

	hl.command = {
		a = {
			bg = Config.plugin.lualine.plain and c.none or c.comm,
			fg = Config.plugin.lualine.plain and c.comm or c.dark,
			gui = Config.plugin.lualine.bold and "bold" or c.none,
		},
	}

	return hl
end

return M
