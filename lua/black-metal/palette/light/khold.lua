---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Phantom, 2002
local M = {
	alt = "#31594e",
	alt_bg = "#e9bec7",
	bg = "#f5e0e5",
	comment = "#664d52",
	constant = "#684e31",
	fg = "#1e1013",
	func = "#793834",
	keyword = "#4e5723",
	line = "#f5e0e5",
	number = "#615029",
	operator = "#694a50",
	property = "#1e1013",
	string = "#4f5729", -- first accent
	type = "#8f342e", -- second accent
	visual = "#eebac6",
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
