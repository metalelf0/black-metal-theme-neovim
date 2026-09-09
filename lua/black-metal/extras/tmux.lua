local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local tmux = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

# Color palette
set -g @black   "${black}"
set -g @grey    "${grey}"
set -g @red     "${red}"
set -g @orange  "${orange}"
set -g @green   "${green}"
set -g @yellow  "${yellow}"
set -g @blue    "${blue}"
set -g @purple  "${purple}"
set -g @magenta "${magenta}"
set -g @cyan    "${cyan}"
set -g @white   "${white}"

# Theme colors
set -g @theme_bg          "${bg}"
set -g @theme_fg          "${fg}"
set -g @theme_alt_bg      "${alt_bg}"
set -g @theme_alt          "${alt}"
set -g @theme_comment      "${comment}"
set -g @theme_visual       "${visual}"
set -g @theme_line         "${line}"

# Status line
set -g status-style "bg=${visual},fg=${fg}"
set -g status-left-style "bg=${visual},fg=${alt}"
set -g status-right-style "bg=${visual},fg=${comment}"

# Window status
set -g window-status-style "bg=${bg},fg=${comment}"
set -g window-status-current-style "bg=${visual},fg=${alt}"
set -g window-status-activity-style "bg=${visual},fg=${orange}"
set -g window-status-bell-style "bg=${visual},fg=${red}"

# Panes
set -g pane-border-style "fg=${grey}"
set -g pane-active-border-style "fg=${alt}"

# Message
set -g message-style "bg=${visual},fg=${fg}"

# Mode
set -g mode-style "bg=${orange},fg=${bg}"

# Clock
set -g clock-mode-colour "${alt}"

# Copy mode
set -g copy-mode-match-style "bg=${orange},fg=${bg}"
set -g copy-mode-current-match-style "bg=${red},fg=${bg}"
]=],
		colors
	)
	return tmux
end

return M