local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upsteam
	colors.theme = info.theme
	local foot_colors = {}
	for k, v in pairs(colors) do
		if type(v) == "string" then
			foot_colors[k] = v:gsub("^#", "")
		end
	end

	local foot = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

[cursor]
color=${fg} ${visual}

[colors]
foreground=${fg}
background=${bg}
# alternate, darker background=${alt_bg}
selection-foreground=${fg}
selection-background=${visual}
urls=${blue}

regular0=${black}
regular1=${red}
regular2=${green}
regular3=${yellow}
regular4=${blue}
regular5=${purple}
regular6=${cyan}
regular7=${fg}

bright0=${grey}
bright1=${red}
bright2=${green}
bright3=${yellow}
bright4=${blue}
bright5=${magenta}
bright6=${cyan}
bright7=${fg}

16=${orange}
17=${alt}
]=],
		foot_colors
	)

	return foot
end

return M
