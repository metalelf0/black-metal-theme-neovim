local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local claude_code = Util.template(
		[=[
{
  "name": "${theme} colors for ${extra}",
  "url": "${url}",
  "upstream": "${upstream}",
  "author": "Andrea Schiavini (original code by Casey Miller)",
  "theme": {
    "background": "${bg}",
    "foreground": "${fg}",
    "alternateBackground": "${alt_bg}",
    "alternateForeground": "${alt}",
    "comment": "${comment}",
    "visualSelection": "${visual}",
    "lineHighlight": "${line}"
  },
  "colors": {
    "black": "${black}",
    "grey": "${grey}",
    "red": "${red}",
    "orange": "${orange}",
    "green": "${green}",
    "yellow": "${yellow}",
    "blue": "${blue}",
    "purple": "${purple}",
    "magenta": "${magenta}",
    "cyan": "${cyan}",
    "white": "${white}"
  },
  "palette": {
    "string": "${string}",
    "number": "${number}",
    "keyword": "${keyword}",
    "function": "${func}",
    "type": "${type}",
    "constant": "${constant}",
    "operator": "${operator}",
    "property": "${property}"
  }
}
]=],
		colors
	)
	return claude_code
end

return M
