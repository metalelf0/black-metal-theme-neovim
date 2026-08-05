---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Twilight of the Idols - In Conspiracy with Satan, 2003
local M = {
	alt = "#3b5959",
	alt_bg = "#d4cfd0",
	bg = "#f2f0ec",
	comment = "#6e685d",
	constant = "#6d6d6d",
	fg = "#242019",
	func = "#696969",
	keyword = "#6b6b6b",
	line = "#f2f0ec",
	number = "#6d6d6d",
	operator = "#6c6a76",
	property = "#242019",
	string = "#3b6213", -- first accent
	type = "#655443", -- second accent
	visual = "#d6c9ad",
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
