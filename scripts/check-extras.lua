-- Usage: nvim --headless --clean -u NONE -l scripts/check-extras.lua
-- Checks all generated extras and confirms generation preserves editor state.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path
vim.opt.rtp:prepend(root)

vim.cmd("cd " .. vim.fn.fnameescape(root))
require("black-metal").setup({ theme = "burzum", trve = false })
vim.cmd.colorscheme("burzum-light-alt")

local black_metal = require("black-metal")
local before_options = black_metal.options()
local before_colors_name = vim.g.colors_name
local before_background = vim.o.background
local before_terminal_colors = {}
for index = 0, 15 do
	before_terminal_colors[index] = vim.g["terminal_color_" .. index]
end

local extras = require("black-metal.extras")
extras.setup()

assert(vim.deep_equal(before_options, black_metal.options()), "extras generation changed colorscheme options")
assert(vim.g.colors_name == before_colors_name, "extras generation changed active colorscheme")
assert(vim.o.background == before_background, "extras generation changed background")
for index = 0, 15 do
	assert(vim.g["terminal_color_" .. index] == before_terminal_colors[index], "extras generation changed terminal colors")
end

local themes = require("black-metal.palette").themes
local expected = 0
for extra, info in pairs(extras.extras) do
	for theme in pairs(themes) do
		for _, variant in ipairs(extras.variants) do
			local name = theme .. variant.suffix
			if info.ext then
				name = name .. "." .. info.ext
			end
			local path = root .. "/extras/" .. extra .. "/" .. name
			assert(vim.fn.filereadable(path) == 1, "missing generated extra: " .. path)
			local contents = table.concat(vim.fn.readfile(path), "\n")
			assert(not contents:match("%${[%w_%.%-]+}"), "unresolved template token in " .. path)
			if extra == "eza" then
				local output = vim.fn.system({ "bash", "-n", path })
				assert(vim.v.shell_error == 0, "invalid Eza shell file " .. path .. ": " .. output)
			end
			expected = expected + 1
		end
	end
end

local generated = vim.fn.globpath(root .. "/extras", "*/*", false, true)
assert(#generated == expected, ("expected %d generated extras, found %d"):format(expected, #generated))
print(("OK: validated %d generated extra files across %d themes and %d variants"):format(expected, vim.tbl_count(themes), #extras.variants))
