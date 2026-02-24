local M = {}
local Util = require("black-metal.util")

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upsteam
	colors.theme = info.theme
	local alacritty = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

# Default colors
[colors.primary]
background = '${bg}'
# alternate, darker background = '${alt_bg}'
foreground = '${fg}'

#[colors.cursor]
#cursor = '${fg}'
#text = '${bg}'

# Normal colors
[colors.normal]
black = '${black}'
red = '${red}'
green = '${green}'
yellow = '${yellow}'
blue = '${blue}'
magenta = '${purple}'
cyan = '${cyan}'
white = '${white}'

# Bright colors
[colors.bright]
black = '${grey}'
red = '${red}'
green = '${green}'
yellow = '${yellow}'
blue = '${blue}'
magenta = '${magenta}'
cyan = '${cyan}'
white = '${white}'

# Indexed Colors
[[colors.indexed_colors]]
index = 16
color = '${orange}'

[[colors.indexed_colors]]
index = 17
color = '${alt}'
]=],
		colors
	)

	return alacritty
end

return M
