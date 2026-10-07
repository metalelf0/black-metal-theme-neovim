---@type black-metal.Theme
--- light variant colors: shared base + accents derived from At the heart of winter, 1999
local M = {
	alt = "#633d36",
	alt_bg = "#c3d6df",
	bg = "#e3eef2",
	comment = "#4d5b66",
	constant = "#3b3e7d",
	fg = "#121b21",
	func = "#345779",
	keyword = "#32577b",
	line = "#e3eef2",
	number = "#2b6264",
	operator = "#4a5c69",
	property = "#121b21",
	string = "#315c87", -- first accent
	type = "#445c73", -- second accent
	visual = "#c0dde7",
	diag_red = "#a13b3b",
	diag_blue = "#3a6ea5",
	diag_yellow = "#8a6d1f",
	diag_green = "#4b6b3f",
}

---@type black-metal.Theme.Terminal
M.colormap = {
	black = M.alt_bg,
	grey = M.comment,
	red = M.diag_red,
	orange = M.number,
	green = M.property,
	yellow = M.func,
	blue = M.constant,
	purple = M.keyword,
	magenta = M.type,
	cyan = M.string,
	white = M.fg,
}

return M
