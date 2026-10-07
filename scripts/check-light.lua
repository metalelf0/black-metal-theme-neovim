-- Usage: nvim --headless --clean -u NONE -l scripts/check-light.lua
-- Checks distinctness (CIE Lab dE) and WCAG contrast across light palettes.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local MIN_PAIR_DE = { base = 9, alt = 9 }
local MIN_BG_DE = { base = 4, alt = 4 }
local MIN_CONTRAST = { fg = 7, comment = 3.5, string = 4.5, type = 4.5, keyword = 3.5, func = 3.5 }
local SIGNATURE = { "bg", "fg", "comment", "visual", "keyword", "func", "constant", "number", "string", "type" }
local MONOCHROME = { darkthrone = true }

local themes = {
	"bathory", "burzum", "dark-funeral", "darkthrone", "emperor", "gorgoroth", "immortal", "impaled-nazarene",
	"khold", "marduk", "mayhem", "nile", "taake", "thyrfing", "venom", "windir",
}

local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
end

local function lin(c)
	return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

local function lum(hex)
	local r, g, b = rgb(hex)
	return 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b)
end

local function contrast(a, b)
	local la, lb = lum(a), lum(b)
	if la < lb then
		la, lb = lb, la
	end
	return (la + 0.05) / (lb + 0.05)
end

local function lab(hex)
	local r, g, b = rgb(hex)
	r, g, b = lin(r), lin(g), lin(b)
	local x = (0.4124 * r + 0.3576 * g + 0.1805 * b) / 0.95047
	local y = 0.2126 * r + 0.7152 * g + 0.0722 * b
	local z = (0.0193 * r + 0.1192 * g + 0.9505 * b) / 1.08883
	local function f(t)
		return t > 0.008856 and t ^ (1 / 3) or 7.787 * t + 16 / 116
	end
	local fx, fy, fz = f(x), f(y), f(z)
	return { 116 * fy - 16, 500 * (fx - fy), 200 * (fy - fz) }
end

local function de(a, b)
	local la, lb = lab(a), lab(b)
	return math.sqrt((la[1] - lb[1]) ^ 2 + (la[2] - lb[2]) ^ 2 + (la[3] - lb[3]) ^ 2)
end

local function load(name, variant)
	package.loaded["black-metal.palette.light." .. name] = nil
	local c = vim.deepcopy(require("black-metal.palette.light." .. name))
	if variant == "alt" then
		c.bg = c.alt_bg
		c.line = c.alt_bg
	end
	return c
end

local failures = 0
local function fail(msg)
	failures = failures + 1
	print("FAIL " .. msg)
end

for _, variant in ipairs({ "base", "alt" }) do
	print(("== %s =="):format(variant))
	local pal = {}
	for _, n in ipairs(themes) do
		pal[n] = load(n, variant)
		for role, min in pairs(MIN_CONTRAST) do
			local ratio = contrast(pal[n][role], pal[n].bg)
			if ratio < min then
				fail(("%s %s: %s/bg contrast %.2f < %.1f"):format(n, variant, role, ratio, min))
			end
		end
	end

	local pairs_ = {}
	for i = 1, #themes do
		for j = i + 1, #themes do
			local a, b = themes[i], themes[j]
			local sum = 0
			for _, role in ipairs(SIGNATURE) do
				sum = sum + de(pal[a][role], pal[b][role])
			end
			table.insert(pairs_, { a = a, b = b, sig = sum / #SIGNATURE, bg = de(pal[a].bg, pal[b].bg) })
		end
	end
	table.sort(pairs_, function(x, y)
		return x.sig < y.sig
	end)
	print("closest by signature dE:")
	for k = 1, 8 do
		local p = pairs_[k]
		print(("  %-18s %-18s sig %5.1f  bg %5.1f"):format(p.a, p.b, p.sig, p.bg))
	end
	for _, p in ipairs(pairs_) do
		local mono = MONOCHROME[p.a] or MONOCHROME[p.b]
		if p.sig < MIN_PAIR_DE[variant] then
			fail(("%s: %s vs %s signature dE %.1f < %.1f"):format(variant, p.a, p.b, p.sig, MIN_PAIR_DE[variant]))
		end
		if not mono and p.bg < MIN_BG_DE[variant] then
			fail(("%s: %s vs %s bg dE %.1f < %.1f"):format(variant, p.a, p.b, p.bg, MIN_BG_DE[variant]))
		end
	end
end

print(failures == 0 and "OK" or ("%d failure(s)"):format(failures))
os.exit(failures == 0 and 0 or 1)
