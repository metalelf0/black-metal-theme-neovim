---@type black-metal.Theme
--- light variant colors: shared base + accents derived from The secrets of the black arts, 1996
local M = {
	alt = "#633d36",
	alt_bg = "#c0cbed",
	bg = "#e3e9f7",
	comment = "#4f5669",
	constant = "#3b3d7d",
	fg = "#121621",
	func = "#345779",
	keyword = "#6c4e2c",
	line = "#e3e9f7",
	number = "#813b37",
	operator = "#4a5369",
	property = "#121621",
	string = "#7f4200", -- first accent
	type = "#20578e", -- second accent
	visual = "#bcccf1",
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
