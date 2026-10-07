---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Hordalands doedskvad, 2005
local M = {
	alt = "#2d4f52",
	alt_bg = "#cdb7c6",
	bg = "#e1d6df",
	comment = "#5d4658",
	constant = "#504b26",
	fg = "#030203",
	func = "#64432b",
	keyword = "#5a4925",
	line = "#e1d6df",
	number = "#6f3c2f",
	operator = "#5d4156",
	property = "#030203",
	string = "#514733", -- first accent
	type = "#57483d", -- second accent
	visual = "#d4b5cd",
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
