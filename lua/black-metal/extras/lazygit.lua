local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local lazygit = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

gui:
  theme:
    activeBorderColor:
      - "${alt}"
      - bold
    inactiveBorderColor:
      - "${comment}"
    optionsTextColor:
      - "${cyan}"
    selectedLineBgColor:
      - "${visual}"
    cherryPickedCommitBgColor:
      - "${visual}"
    cherryPickedCommitFgColor:
      - "${alt}"
    unstagedChangesColor:
      - "${red}"
    defaultFgColor:
      - "${fg}"
    searchingActiveBorderColor:
      - "${orange}"
  commitColors:
    "♥": "${red}"
    "↻": "${yellow}"
    "~": "${blue}"
    "→": "${green}"
    "☀": "${orange}"
    "✗": "${magenta}"
    "⚑": "${cyan}"
    "▼": "${purple}"
    "▲": "${green}"
    "M": "${orange}"
]=],
		colors
	)
	return lazygit
end

return M
