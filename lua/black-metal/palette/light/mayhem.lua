---@type black-metal.Theme
--- light variant colors: shared base + accents derived from The dawn of the black hearts, 1995
local M = {
	alt = "#324c5c",
	alt_bg = "#e4afaf",
	bg = "#f4edd2",
	comment = "#524b3e",
	constant = "#444c24",
	fg = "#000000",
	func = "#554925",
	keyword = "#534822",
	line = "#f4edd2",
	number = "#683e2c",
	operator = "#514939",
	property = "#000000",
	string = "#5a480c", -- first accent
	type = "#5c4400", -- second accent
	visual = "#f0e1a8",
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
