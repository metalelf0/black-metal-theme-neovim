local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upsteam
	colors.theme = info.theme
	local wezterm = Util.template(
		[=[
[colors]
foreground = "${fg}"
background = "${bg}"
# background = "${alt_bg}" # alternate, darker bg
cursor_bg = "${fg}"
cursor_border = "${fg}"
cursor_fg = "${bg}"
selection_bg = "${visual}"
selection_fg = "${fg}"
split = "${grey}"
compose_cursor = "${orange}"
scrollbar_thumb = "${grey}"

ansi = ["${black}", "${red}", "${green}", "${yellow}", "${blue}", "${purple}", "${cyan}", "${fg}"]
brights = ["${grey}", "${red}", "${green}", "${yellow}", "${blue}", "${magenta}", "${cyan}", "${fg}"]

[colors.tab_bar]
inactive_tab_edge = "${grey}"
background = "${bg}"

[colors.tab_bar.active_tab]
fg_color = "${alt}"
bg_color = "${visual}"

[colors.tab_bar.inactive_tab]
fg_color = "${comment}"
bg_color = "${line}"

[colors.tab_bar.inactive_tab_hover]
fg_color = "${comment}"
bg_color = "${line}"
# intensity = "Bold"

[colors.tab_bar.new_tab_hover]
fg_color = "${alt}"
bg_color = "${visual}"
intensity = "Bold"

[colors.tab_bar.new_tab]
fg_color = "${alt}"
bg_color = "${bg}"

[metadata]
aliases = []
name = "${theme}"
url = "${url}"
upstream = "${upstream}"
author = "Andrea Schiavini (original code by Casey Miller)"
]=],
		colors
	)
	return wezterm
end

return M
