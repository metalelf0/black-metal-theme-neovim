-- Usage: nvim --headless --clean -u NONE -l scripts/check-alt.lua
-- Checks that alternate backgrounds keep the selection color as visible as in
-- the base variant, for both the dark and the light palettes.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local Util = require("black-metal.util")
local palette = require("black-metal.palette")

local MIN_SELECTION_DL = 3
local TOLERANCE = 0.5

local themes = {
	"bathory", "burzum", "dark-funeral", "darkthrone", "emperor", "gorgoroth", "immortal", "impaled-nazarene",
	"khold", "marduk", "mayhem", "nile", "taake", "thyrfing", "venom", "windir",
}

local failures = 0
local function fail(msg)
	failures = failures + 1
	print("FAIL " .. msg)
end

for _, variant in ipairs({ "dark", "light" }) do
	print(("== %s =="):format(variant))
	for _, theme in ipairs(themes) do
		local base = palette.get(theme, variant)
		local alt = palette.with_alt_bg(palette.get(theme, variant))

		local base_dl = math.abs(Util.lightness(base.visual) - Util.lightness(base.bg))
		local alt_dl = math.abs(Util.lightness(alt.visual) - Util.lightness(alt.bg))

		if alt_dl < MIN_SELECTION_DL then
			fail(("%s-%s: selection only %.1f L* from the background, need %.1f"):format(theme, variant, alt_dl, MIN_SELECTION_DL))
		end
		if alt_dl < base_dl - TOLERANCE then
			fail(("%s-%s: selection lost separation, %.1f L* (base %.1f)"):format(theme, variant, alt_dl, base_dl))
		end
		print(("  %-18s bg %s visual %s (%.1f L*)"):format(theme, alt.bg, alt.visual, alt_dl))
	end
end

print(failures == 0 and "OK" or ("%d failure(s)"):format(failures))
os.exit(failures == 0 and 0 or 1)
