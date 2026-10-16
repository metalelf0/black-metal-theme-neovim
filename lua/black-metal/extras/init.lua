local M = {}

---@alias Extra {ext:nil|string, url:string, label:string}
---@alias ExtraVariant {suffix:string, variant:string, alt_bg:boolean, label:string}

-- map of plugin name to plugin extension
--- @type table<string, Extra>
M.extras = {
    -- stylua: ignore start
    alacritty = {ext = "toml", url = "https://github.com/alacritty/alacritty", label = "Alacritty"},
    fish = {ext = "fish", url = "https://fishshell.com/docs/current/index.html", label = "Fish"},
    fish_themes = {ext = "theme", url = "https://fishshell.com/docs/current/interactive.html#syntax-highlighting", label = "Fish Themes"},
    foot = {ext = "ini", url = "https://codeberg.org/dnkl/foot", label = "Foot"},
    fzf = { ext = "zsh", url = "https://github.com/junegunn/fzf", label = "Fzf"},
    ghostty = { url = "https://ghostty.org/", label = "Ghostty"},
    kitty = {ext = "conf", url = "https://sw.kovidgoyal.net/kitty/conf.html", label = "Kitty"},
    wezterm = {ext = "toml", url = "https://wezfurlong.org/wezterm/config/files.html", label = "WezTerm"},
    windows_terminal = {ext = "json", url = "https://aka.ms/terminal-documentation", label = "Windows Terminal"},
    yazi = { ext = "toml", url = "https://github.com/sxyazi/yazi", label = "Yazi"},
    bat = {ext = "tmTheme", url = "https://github.com/sharkdp/bat", label = "Bat"},
    claude_code = {ext = "json", url = "https://claude.ai/code", label = "Claude Code"},
    eza = {ext = "sh", url = "https://github.com/eza-community/eza", label = "Eza"},
    herdr = {ext = "toml", url = "https://github.com/herd", label = "Herdr"},
    lazygit = {ext = "yml", url = "https://github.com/jesseduffield/lazygit", label = "Lazygit"},
    opencode = {ext = "json", url = "https://opencode.ai", label = "Opencode"},
    pi = {ext = "yaml", url = "https://github.com/pi", label = "Pi"},
    starship = {ext = "toml", url = "https://starship.rs", label = "Starship"},
    tmux = {ext = "conf", url = "https://github.com/tmux/tmux", label = "Tmux"},
	-- stylua: ignore end
}

---@param contents string file contents (extra theme)
---@param fname string filename to save extra
local function write(contents, fname)
	print("[write] extras/" .. fname)
	vim.fn.mkdir(vim.fs.dirname("extras/" .. fname), "p")
	local path = "extras/" .. fname
	local file, open_error = io.open(path, "w")
	assert(file, "could not open " .. path .. ": " .. tostring(open_error))
	local wrote, write_error = file:write(contents)
	if not wrote then
		file:close()
		error("could not write " .. path .. ": " .. tostring(write_error))
	end
	local closed, close_error = file:close()
	assert(closed, "could not close " .. path .. ": " .. tostring(close_error))
end

M.variants = {
	{ suffix = "", variant = "dark", alt_bg = false, label = "" },
	{ suffix = "-alt", variant = "dark", alt_bg = true, label = "ALT" },
	{ suffix = "-light", variant = "light", alt_bg = false, label = "LIGHT" },
	{ suffix = "-light-alt", variant = "light", alt_bg = true, label = "LIGHT ALT" },
}

---Generates themes found in the Extras folder. Templates are stored in `black-metal/extras/`.
function M.setup()
	local themes = require("black-metal.palette").themes
	local terminal = require("black-metal.terminal")

	for extra, info in pairs(M.extras) do
		package.loaded["black-metal.extras." .. extra] = nil
		local template = require("black-metal.extras." .. extra)
		for _, theme in pairs(themes) do
			for _, variant in ipairs(M.variants) do
				local theme_slug = theme .. variant.suffix
				local fname = extra .. "/" .. theme_slug
				if info.ext then
					fname = fname .. "." .. info.ext
				end
				local url = "https://github.com/metalelf0/black-metal.nvim/raw/main/extras/" .. fname
				local label = variant.label == "" and string.upper(theme) or (string.upper(theme) .. " " .. variant.label)
				local palette = terminal.colors_for(theme, variant.variant, variant.alt_bg, true)
				local contents = template.generate(palette, {
					extra = info.label,
					url = info.url,
					upstream = url,
					theme = label,
					theme_slug = theme_slug,
					variant = variant.variant,
					alt_bg = variant.alt_bg,
				})
				local unresolved = contents:match("%${[%w_%.%-]+}")
				if unresolved then
					error("unresolved template value " .. unresolved .. " in " .. fname)
				end
				write(contents, fname)
			end
		end
	end
end

return M
