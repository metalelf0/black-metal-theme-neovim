---@type black-metal.Theme
--- colors taken from Hammerheart, 1990
local M = {
	alt = "#5f8787",
	alt_bg = "#3E2018",
	bg = "#000000",
	comment = "#505050",
	constant = "#aaaaaa",
	fg = "#c1c1c1",
	func = "#888888",
	keyword = "#999999",
	line = "#000000",
	number = "#aaaaaa",
	operator = "#9b99a3",
	property = "#c1c1c1",
	string = "#fbcb97", -- first accent
	type = "#e78a43", -- second accent
	visual = "#333333",
	diag_red = "#5f8787",
	diag_blue = "#999999",
	diag_yellow = "#5f8787",
	diag_green = "#6e4c4c",
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
