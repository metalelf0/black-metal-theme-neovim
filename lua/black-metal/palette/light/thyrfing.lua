---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Valdr Galga, 1999
local M = {
	alt = "#2f5651",
	alt_bg = "#eabbb8",
	bg = "#f5dedb",
	comment = "#634e4b",
	constant = "#614f2e",
	fg = "#170e0d",
	func = "#794134",
	keyword = "#7b4132",
	line = "#f5dedb",
	number = "#81374a",
	operator = "#634945",
	property = "#170e0d",
	string = "#99270a", -- first accent
	type = "#912f18", -- second accent
	visual = "#efb9b3",
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
