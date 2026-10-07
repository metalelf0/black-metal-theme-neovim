---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Arntor, 1999
local M = {
	alt = "#634436",
	alt_bg = "#bfdeb5",
	bg = "#ddecd5",
	comment = "#506049",
	constant = "#423b7d",
	fg = "#172112",
	func = "#344d79",
	keyword = "#5e5e26",
	line = "#ddecd5",
	number = "#735431",
	operator = "#4d6043",
	property = "#172112",
	string = "#5e5e12", -- first accent
	type = "#3e5b8e", -- second accent
	visual = "#c3e3b0",
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
