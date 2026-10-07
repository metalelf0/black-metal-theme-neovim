---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Transilvanian Hunger, 1994
local M = {
	alt = "#444444",
	alt_bg = "#f2f2f0",
	bg = "#f2f2f0",
	comment = "#6a6a6a",
	constant = "#5e5e5e",
	fg = "#1a1a1a",
	func = "#555555",
	keyword = "#4a4a4a",
	line = "#f2f2f0",
	number = "#5e5e5e",
	operator = "#666666",
	property = "#1a1a1a",
	string = "#000000", -- first accent
	type = "#000000", -- second accent
	visual = "#d9d9d6",
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
