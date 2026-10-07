---@type black-metal.Theme
--- light variant colors: shared base + accents derived from In the nightside eclipse, 1994
local M = {
	alt = "#595131",
	alt_bg = "#cfc1e6",
	bg = "#e9e2f3",
	comment = "#584f69",
	constant = "#613b7d",
	fg = "#15101e",
	func = "#3c3479",
	keyword = "#5b327b",
	line = "#e9e2f3",
	number = "#3e3781",
	operator = "#574c6c",
	property = "#15101e",
	string = "#5e486f", -- first accent
	type = "#4431d4", -- second accent
	visual = "#d0bee9",
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
