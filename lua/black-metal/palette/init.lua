local M = {}

---@class black-metal.Theme
---@field alt string highlight
---@field alt_bg string dim alternate background
---@field bg string background
---@field comment string comments
---@field constant string constants
---@field fg string foreground
---@field func string functions
---@field keyword string keywords
---@field line string line highlights: e.g. cursor line
---@field number string number/boolean
---@field operator string operators
---@field property string class properties
---@field string string strings
---@field type string types
---@field visual string visual selection
---@field diag_red string diagnostics red color (e.g. error)
---@field diag_blue string diagnostics blue color (e.g. hint)
---@field diag_yellow string diagnostics yellow color (e.g. warning)
---@field diag_green string diagnostics green color (e.g. diffadd)
---@field colormap nil|black-metal.Theme.Terminal mapping to terminal colors

---@class black-metal.Theme.Terminal
---@field black string
---@field grey string
---@field red string
---@field orange string
---@field green string
---@field yellow string
---@field blue string
---@field purple string
---@field magenta string
---@field cyan string
---@field white string

---@enum Themes
M.themes = {
	["dark-funeral"] = "dark-funeral",
	["impaled-nazarene"] = "impaled-nazarene",
	bathory = "bathory",
	burzum = "burzum",
	darkthrone = "darkthrone",
	emperor = "emperor",
	gorgoroth = "gorgoroth",
	immortal = "immortal",
	khold = "khold",
	marduk = "marduk",
	mayhem = "mayhem",
	nile = "nile",
	taake = "taake",
	thyrfing = "thyrfing",
	venom = "venom",
	windir = "windir",
}

for key, theme in pairs(M.themes) do
	M[key] = require("black-metal.palette." .. theme)
end

---Returns a read-only copy of the light or dark variant of a theme.
---@param theme string
---@param variant string
M.get = function(theme, variant)
	if variant == "light" then
		return require("black-metal.palette.day").get()
	else
		return vim.deepcopy(M[theme])
	end
end

return M
