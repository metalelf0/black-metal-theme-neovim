-- Usage: nvim --headless --clean -u NONE -l scripts/check-highlight-overrides.lua
-- Checks dynamic palette callbacks and palette references across theme switches.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path
vim.opt.rtp:prepend(root)

local utils = require("black-metal.utils")
local callback_calls = {}
local invalid_calls = 0

require("black-metal").setup({
	trve = false,
	colors = { type = "#123456" },
	highlights = {
		Hashtag = {
			fg = "$type",
			bg = function(palette, variant)
				table.insert(callback_calls, { theme = require("black-metal").options().theme, variant = variant })
				return utils.blend(palette.type, palette.bg, 0.1)
			end,
		},
		InvalidHashtag = {
			fg = function()
				invalid_calls = invalid_calls + 1
				return "not-a-color"
			end,
			bg = "$bg",
		},
	},
})

local function check_theme(scheme, theme, variant, alt_bg)
	vim.cmd.colorscheme(scheme)
	local palette = require("black-metal.palette").get(theme, variant)
	palette.type = "#123456"
	if alt_bg then
		palette.bg = palette.alt_bg
		palette.line = palette.alt_bg
	end
	local hashtag = vim.api.nvim_get_hl(0, { name = "Hashtag" })
	assert(hashtag.fg == vim.api.nvim_get_color_by_name(palette.type), scheme .. ": $type foreground did not resolve")
	assert(
		hashtag.bg == vim.api.nvim_get_color_by_name(utils.blend(palette.type, palette.bg, 0.1)),
		scheme .. ": dynamic background did not resolve"
	)

	local invalid = vim.api.nvim_get_hl(0, { name = "InvalidHashtag" })
	assert(invalid.bg == vim.api.nvim_get_color_by_name(palette.bg), scheme .. ": valid bg lost when fg callback failed")
	assert(invalid.fg == nil, scheme .. ": invalid callback color was applied")
end

check_theme("bathory", "bathory", "dark", false)
vim.api.nvim_set_hl(0, "Hashtag", { link = "Type" })
require("black-metal.highlights").setup()
assert(
	vim.api.nvim_get_hl(0, { name = "Hashtag", link = true }).link == nil,
	"setting Hashtag attributes did not unlink it from Type"
)
check_theme("bathory-alt", "bathory", "dark", true)
check_theme("burzum", "burzum", "dark", false)
check_theme("burzum-light", "burzum", "light", false)

assert(#callback_calls == 5, "dynamic callback did not run on each colorscheme load and highlight setup")
assert(invalid_calls == 5, "invalid callback did not run on each colorscheme load and highlight setup")
assert(callback_calls[1].theme == "bathory" and callback_calls[4].theme == "burzum", "callback observed stale theme")
assert(callback_calls[5].variant == "light", "callback observed stale variant")
print("OK: dynamic highlight overrides recompute across theme and variant switches")
