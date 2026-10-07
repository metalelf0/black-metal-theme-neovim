---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Welcome to hell, 1981
local M = {
	alt = "#325c4f",
	alt_bg = "#ddcacc",
	bg = "#f3f2f2",
	comment = "#6c5151",
	constant = "#6f5034",
	fg = "#211212",
	func = "#793534",
	keyword = "#5e5526",
	line = "#f3f2f2",
	number = "#764b32",
	operator = "#6f4e4e",
	property = "#211212",
	string = "#5e5527", -- first accent
	type = "#ae0200", -- second accent
	visual = "#e0d6d6",
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
