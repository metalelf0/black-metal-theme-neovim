---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Tol Cormpt Norz Norz Norz..., 1993
local M = {
	alt = "#365063",
	alt_bg = "#dbe7ac",
	bg = "#edf1d5",
	comment = "#61664d",
	constant = "#5c6831",
	fg = "#1f2112",
	func = "#6e602f",
	keyword = "#7b3632",
	line = "#edf1d5",
	number = "#813756",
	operator = "#5e6345",
	property = "#1f2112",
	string = "#c30c03", -- first accent
	type = "#755f1a", -- second accent
	visual = "#e2ebad",
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
