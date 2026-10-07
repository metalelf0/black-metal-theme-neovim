---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Black seeds of vengeance, 2000
local M = {
	alt = "#364563",
	alt_bg = "#e5c4a4",
	bg = "#ede0c9",
	comment = "#5d5346",
	constant = "#445a2b",
	fg = "#17130d",
	func = "#555525",
	keyword = "#6c4e2c",
	line = "#ede0c9",
	number = "#813a37",
	operator = "#5d5141",
	property = "#17130d",
	string = "#634f3a", -- first accent
	type = "#565633", -- second accent
	visual = "#e8cea1",
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
