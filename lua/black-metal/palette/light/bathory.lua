---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Hammerheart, 1990
local M = {
	alt = "#32595c",
	alt_bg = "#eac2b8",
	bg = "#f7e7de",
	comment = "#63524b",
	constant = "#5a552b",
	fg = "#1e1510",
	func = "#6e4b2f",
	keyword = "#6c4e2c",
	line = "#f7e7de",
	number = "#813b37",
	operator = "#634f45",
	property = "#1e1510",
	string = "#7f4200", -- first accent
	type = "#8a3c00", -- second accent
	visual = "#f2ccb5",
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
