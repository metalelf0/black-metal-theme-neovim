---@type black-metal.Theme
--- light variant colors: shared base + accents derived from Panzer Division Marduk, 1999
local M = {
	alt = "#63365b",
	alt_bg = "#bbd3d1",
	bg = "#dbe1e0",
	comment = "#445a58",
	constant = "#2c5e5d",
	fg = "#0e1a19",
	func = "#296047",
	keyword = "#265e3c",
	line = "#dbe1e0",
	number = "#2f6129",
	operator = "#3f5a56",
	property = "#0e1a19",
	string = "#4b5950", -- first accent
	type = "#495b52", -- second accent
	visual = "#bcd2ce",
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
