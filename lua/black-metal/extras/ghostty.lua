local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local ghostty = Util.template(
		[=[
# vim:ft=ghostty

# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

background = ${bg}
# alternate, darker background ${alt_bg}
foreground = ${fg}
selection-background = ${visual}
selection-foreground = ${fg}
cursor-color = ${fg}

# normal
palette = 0 =${black}
palette = 1 =${red}
palette = 2 =${green}
palette = 3 =${yellow}
palette = 4 =${blue}
palette = 5 =${purple}
palette = 6 =${cyan}
palette = 7 =${fg}

# bright
palette = 8 =${grey}
palette = 9 =${red}
palette = 10 =${green}
palette = 11 =${yellow}
palette = 12 =${blue}
palette = 13 =${magenta}
palette = 14 =${cyan}
palette = 15 =${fg}
]=],
		colors
	)
	return ghostty
end

return M
