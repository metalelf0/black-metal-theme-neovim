local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local starship = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

[palette]
black = "${black}"
grey = "${grey}"
red = "${red}"
orange = "${orange}"
green = "${green}"
yellow = "${yellow}"
blue = "${blue}"
purple = "${purple}"
magenta = "${magenta}"
cyan = "${cyan}"
white = "${white}"

[theme]
bg = "${bg}"
fg = "${fg}"
alt_bg = "${alt_bg}"
alt = "${alt}"
comment = "${comment}"
visual = "${visual}"
line = "${line}"

# Format for cmd_duration
[cmd_duration]
format = "[$duration]($style) "
style = "bg:$visual fg:$fg"

# Directory
[directory]
style = "fg:$alt"

# Git branch
[git_branch]
symbol = "🌱 "
style = "fg:$orange"

# Git status
[git_status]
style = "fg:$green"

# Hostname
[hostname]
ssh_symbol = "🔒 "
style = "fg:$yellow"

# Kubernetes
[kubernetes]
symbol = "☸️  "
style = "fg:$blue"

# Python
[python]
symbol = "🐍 "
style = "fg:$green"

# Rust
[rust]
symbol = "🦀 "
style = "fg:$red"

# Time
[time]
format = "[$time]($style) "
style = "fg:$comment"

# Username
[username]
style_root = "fg:$red"
style_user = "fg:$cyan"
]=],
		colors
	)
	return starship
end

return M
