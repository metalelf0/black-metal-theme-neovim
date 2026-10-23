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
local python_tomllib = vim.fn.executable("python3") == 1
	and vim.fn.system({ "python3", "-c", "import tomllib" })
python_tomllib = python_tomllib and vim.v.shell_error == 0

assert(vim.deep_equal(before_options, black_metal.options()), "extras generation changed colorscheme options")
assert(vim.g.colors_name == before_colors_name, "extras generation changed active colorscheme")
assert(vim.o.background == before_background, "extras generation changed background")
for index = 0, 15 do
	assert(vim.g["terminal_color_" .. index] == before_terminal_colors[index], "extras generation changed terminal colors")
end

local python_yaml = false
if vim.fn.executable("python3") == 1 then
	vim.fn.system({ "python3", "-c", "import yaml" })
	python_yaml = vim.v.shell_error == 0
end
local has_eza = vim.fn.executable("eza") == 1
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
				if python_yaml then
					local output = vim.fn.system({
						"python3",
						"-c",
						[[import re, sys, yaml
def leaves(node):
    if isinstance(node, dict) and "foreground" not in node:
        for value in node.values():
            yield from leaves(value)
    else:
        yield node
data = yaml.safe_load(open(sys.argv[1]))
assert len(data) >= 20, "too few sections"
for leaf in leaves(data):
    assert re.fullmatch(r"#[0-9a-fA-F]{6}", leaf["foreground"]), leaf]],
						path,
					})
					assert(vim.v.shell_error == 0, "invalid Eza YAML " .. path .. ": " .. output)
				end
				if has_eza then
					local dir = vim.fn.tempname()
					vim.fn.mkdir(dir, "p")
					vim.fn.writefile(vim.fn.readfile(path), dir .. "/theme.yml")
					local result = vim.system({ "eza", "-l", "--git", root }, { env = { EZA_CONFIG_DIR = dir }, text = true }):wait()
					vim.fn.delete(dir, "rf")
					assert(result.code == 0 and result.stderr == "", "invalid Eza theme " .. path .. ": " .. result.stderr)
				end
			elseif extra == "helix" and python_tomllib then
				local output = vim.fn.system({
					"python3",
					"-c",
					"import sys, tomllib; tomllib.load(open(sys.argv[1], 'rb'))",
					path,
				})
				assert(vim.v.shell_error == 0, "invalid Helix TOML " .. path .. ": " .. output)
			end
			expected = expected + 1
		end
	end
end

local generated = vim.fn.globpath(root .. "/extras", "*/*", false, true)
assert(#generated == expected, ("expected %d generated extras, found %d"):format(expected, #generated))
print(("OK: validated %d generated extra files across %d themes and %d variants"):format(expected, vim.tbl_count(themes), #extras.variants))
