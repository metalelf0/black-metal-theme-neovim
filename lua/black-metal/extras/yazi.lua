local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upsteam
	colors.theme = info.theme
	local yazi = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

[manager]
cwd = { fg = "${func}" }

hovered         = { fg = "${property}", bg = "${line}" }
preview_hovered = { fg = "${property}", bg = "${line}" }

find_keyword  = { fg = "${alt}", italic = true }
find_position = { fg = "${alt}", bg = "reset", italic = true }

marker_copied   = { fg = "${string}" }
marker_cut      = { fg = "${error}" }
marker_selected = { fg = "${alt}" }

tab_active   = { fg = "${alt}", bg = "${visual}" }
tab_inactive = { fg = "${comment}", bg = "${visual}" }
tab_width    = 1

count_cut      = { fg = "${alt}", bg = "${line}" }
count_copied   = { fg = "${alt}", bg = "${line}" }
count_selected = { fg = "${alt}", bg = "${line}" }

border_symbol = "│"
border_style  = { fg = "${comment}" }

[mode]
normal_main   = { fg = "${bg}", bg = "${blue}", bold = true }
normal_alt    = { fg = "${bg}", bg = "${blue}", bold = true }
select_main   = { fg = "${bg}", bg = "${purple}", bold = true }
select_alt    = { fg = "${bg}", bg = "${purple}", bold = true }
unset_main    = { fg = "${bg}", bg = "${cyan}", bold = true }
unset_alt     = { fg = "${bg}", bg = "${cyan}", bold = true }

[status]
separator_open  = ""
separator_close = ""
separator_style = { fg = "${visual}", bg = "${visual}" }

progress_label  = { fg = "${alt}", bold = true }
progress_normal = { fg = "${alt}", bg = "${visual}" }
progress_error  = { fg = "${bg}", bg = "${error}" }

permissions_t = { fg = "${fg}" }
permissions_r = { fg = "${yellow}" }
permissions_w = { fg = "${red}" }
permissions_x = { fg = "${blue}" }
permissions_s = { fg = "${operator}" }

[input]
border   = { fg = "${comment}" }
title    = {}
value    = {}
selected = { reversed = true }

[select]
border   = { fg = "${comment}" }
active   = { fg = "${keyword}" }
inactive = {}

[tasks]
border  = { fg = "${comment}" }
title   = {}
hovered = { underline = true }

[which]
mask            = { bg = "${dim}" }
cand            = { fg = "${property}" }
rest            = { fg = "${type}" }
desc            = { fg = "${string}" }
separator       = "  "
separator_style = { fg = "${operator}"}

[help]
on      = { fg = "${type}" }
run    = { fg = "${string}" }
desc    = { fg = "${comment}" }
hovered = { fg = "${property}", bg = "${line}", bold = true }
footer  = { fg = "${comment}", bg = "${line}" }

[filetype]
rules = [
# Media
{ mime = "image/*", fg = "${magenta}"},
{ mime = "{audio,video}/*", fg = "${string}"},

# Archives
{ mime = "application/{,g}zip", fg = "${red}"},
{ mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}", fg = "${red}"},

# Fallback
{ name = "*", fg = "${fg}"},
{ name = "*/", fg = "${func}"}
]
  ]=],
		colors
	)
	return yazi
end

return M
