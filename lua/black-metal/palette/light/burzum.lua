---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Filosofem, 1996
local M = {
	alt = "#63365c",
	alt_bg = "#e8d5ba",
	bg = "#e1efe8",
	comment = "#4b6357",
	constant = "#306562",
	fg = "#12211a",
	func = "#2c6749",
	keyword = "#476529",
	line = "#e1efe8",
	number = "#5b5d28",
	operator = "#456354",
	property = "#12211a",
	string = "#3d6714", -- first accent
	type = "#35644c", -- second accent
	visual = "#bfe3d1",
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
