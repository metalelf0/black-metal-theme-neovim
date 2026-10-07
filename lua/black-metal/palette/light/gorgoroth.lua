---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Twilight of the Idols - In Conspiracy with Satan, 2003
local M = {
	alt = "#315459",
	alt_bg = "#cfbfc7",
	bg = "#e6e0e2",
	comment = "#604954",
	constant = "#535127",
	fg = "#11090d",
	func = "#67492c",
	keyword = "#3d5723",
	line = "#e6e0e2",
	number = "#4d4f22",
	operator = "#634554",
	property = "#11090d",
	string = "#335511", -- first accent
	type = "#5c4c3d", -- second accent
	visual = "#d7c1c8",
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
