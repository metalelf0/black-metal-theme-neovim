local M = {}
local Util = require("black-metal.util")

function M.get()
	---@type black-metal.Config
	local Config = require("black-metal").options()
	---@type black-metal.Theme
	local c = require("black-metal.palette").get(Config.theme, Config.variant)
	local hl = {}

	local darkgutter
	if Config.alt_bg then
		c.bg = c.alt_bg
		c.line = c.alt_bg
		darkgutter = Util.blend(c.bg, 0.85, "#000000")
	else
		darkgutter = c.alt_bg
	end

	hl.ColorColumn = { bg = c.line }
	hl.Conceal = { fg = c.func, bg = Config.transparent and "none" or c.bg }
	hl.CurSearch = { fg = c.type, bg = c.visual }
	hl.Cursor = { fmt = "reverse" }
	hl.vCursor = { fmt = "reverse" }
	hl.iCursor = { fmt = "reverse" }
	hl.lCursor = { fmt = "reverse" }
	hl.CursorIM = { fmt = "reverse" }
	hl.CursorColumn = { bg = c.line }
	hl.CursorLine = { bg = c.line }
	hl.CursorLineNr = {
		fg = c.fg,
		bg = ((Config.cursorline_gutter and c.line or nil) or (Config.dark_gutter and darkgutter or "none")) or c.bg,
	}
	hl.CursorLineSign = { bg = Config.cursorline_gutter and c.line or "none" }
	hl.CursorLineFold = {
		fg = c.fg,
		bg = Config.cursorline_gutter and c.line or "none",
	}
	hl.Debug = { fg = c.operator }
	hl.debugPC = { fg = c.diag_red }
	hl.debugBreakpoint = { fg = c.diag_red }
	hl.DiffAdd = { bg = Util.blend(c.diag_green, 0.3, c.bg) }
	hl.DiffChange = { bg = Util.blend(c.diag_blue, 0.2, c.bg) }
	hl.DiffDelete = { bg = Util.blend(c.diag_red, 0.4, c.bg) }
	hl.DiffText = { fg = c.fg }
	hl.Directory = { fg = c.func }
	hl.ErrorMsg = { fg = c.diag_red, fmt = "bold" }
	hl.EndOfBuffer = { fg = Config.show_eob and c.comment or c.bg }
	hl.FloatBorder = { fg = c.comment, bg = Config.plain_float and "none" or c.bg }
	hl.FloatTitle = { fg = c.comment, bg = Config.plain_float and "none" or c.line }
	hl.Folded = { fg = c.comment, bg = Config.transparent and "none" or c.line }
	hl.FoldColumn = {
		fg = c.comment,
		bg = ((Config.transparent and "none" or nil) or (Config.dark_gutter and darkgutter or nil)) or c.bg,
	}
	hl.IncSearch = { fg = c.type, bg = c.visual }
	hl.LineNr = {
		fg = c.comment,
		bg = ((Config.transparent and "none" or nil) or (Config.dark_gutter and darkgutter or nil)) or c.bg,
	}
	hl.MatchParen = { fg = c.fg, bg = c.visual, fmt = "bold" }
	hl.ModeMsg = { fg = c.fg, fmt = "bold" }
	hl.MoreMsg = { fg = c.func, fmt = "bold" }
	hl.MsgSeparator = { fg = c.string, bg = c.line, fmt = "bold" }
	hl.NonText = { fg = c.comment }
	hl.Normal = { fg = c.fg, bg = Config.transparent and "none" or c.bg }
	hl.NormalFloat = {
		fg = c.fg,
		bg = (Config.transparent or Config.plain_float) and "none" or c.line,
	}
	hl.Pmenu = { fg = c.fg, bg = Config.plain_float and "none" or c.visual }
	hl.PmenuSbar = { bg = c.line }
	hl.PmenuSel = { fg = c.diag_blue, bg = Config.transparent and "none" or c.line }
	hl.PmenuThumb = { bg = c.visual }
	hl.Question = { fg = c.constant }
	hl.QuickFixLine = { fg = c.func, fmt = "underline" }
	hl.Search = { fg = c.diag_blue, bg = c.visual }
	hl.SignColumn = {
		fg = c.fg,
		bg = ((Config.transparent and "none" or nil) or (Config.dark_gutter and darkgutter)) or c.bg,
	}
	hl.SpecialKey = { fg = c.comment }
	hl.SpellBad = { fg = "none", fmt = "undercurl", sp = c.diag_red }
	hl.SpellCap = { fg = "none", fmt = "undercurl", sp = c.diag_yellow }
	hl.SpellLocal = { fg = "none", fmt = "undercurl", sp = c.diag_blue }
	hl.SpellRare = { fg = "none", fmt = "undercurl", sp = c.diag_blue }
	hl.StatusLine = { fg = c.comment, bg = c.line }
	hl.StatusLineTerm = { fg = c.comment, bg = c.line }
	hl.StatusLineNC = { fg = c.comment, bg = c.line }
	hl.StatusLineTermNC = { fg = c.comment, bg = c.line }
	hl.Substitute = { fg = c.type, bg = c.visual }
	hl.TabLine = { fg = c.comment, bg = c.line }
	hl.TabLineFill = { fg = c.comment, bg = c.line }
	hl.TabLineSel = { fg = c.diag_blue, bg = c.visual }
	hl.Terminal = { fg = c.fg, bg = Config.transparent and "none" or c.bg }
	hl.ToolbarButton = { fg = c.bg, bg = c.visual }
	hl.ToolbarLine = { fg = c.fg }
	hl.Visual = { fg = c.alt, bg = c.visual }
	hl.VisualNOS = { fg = "none", bg = c.comment, fmt = "underline" }
	hl.WarningMsg = { fg = c.diag_yellow, fmt = "bold" }
	hl.Whitespace = { fg = c.comment }
	hl.WildMenu = { fg = c.diag_blue, bg = Util.blend(c.diag_blue, 0.1, c.bg) }
	hl.WinSeparator = { fg = c.comment }
	return hl
end

return M
