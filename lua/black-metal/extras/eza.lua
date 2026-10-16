local Util = require("black-metal.util")

local M = {}

local function eza_color(color)
	local red, green, blue = color:match("^#(%x%x)(%x%x)(%x%x)$")
	assert(red and green and blue, "invalid hex color: " .. tostring(color))
	return string.format("38;2;%d;%d;%d", tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16))
end

function M.generate(colors, info)
	local color = function(name)
		return eza_color(colors[name])
	end

	local eza_colors = {
		theme = info.theme,
		theme_slug = info.theme_slug or info.theme:lower(),
		extra = info.extra,
		url = info.url,
		upstream = info.upstream,
		directory = color("func"),
		executable = color("green"),
		file = color("fg"),
		link = color("cyan"),
		orphan = color("diag_red"),
		pipe = color("purple"),
		socket = color("cyan"),
		device = color("yellow"),
		permission = color("yellow"),
		permission_write = color("diag_red"),
		permission_exec = color("green"),
		special = color("diag_red"),
		attribute = color("comment"),
		owner = color("fg"),
		group = color("grey"),
		user = color("yellow"),
		user_none = color("grey"),
		group_owner = color("func"),
		group_none = color("grey"),
		date = color("comment"),
		inode = color("dim"),
		links = color("comment"),
		link_path = color("cyan"),
		git_added = color("green"),
		git_modified = color("blue"),
		git_deleted = color("diag_red"),
		git_renamed = color("cyan"),
		git_typechange = color("yellow"),
		git_ignored = color("dim"),
		git_conflict = color("orange"),
		header = color("fg"),
	}

	local eza = Util.template([=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)
#
# Install: source this file from your shell rc.
#   source /path/to/extras/eza/${theme_slug}.sh

export EZA_COLORS="\
di=${directory};1:\
ex=${executable}:\
fi=${file}:\
ln=${link}:\
or=${orphan}:\
pi=${pipe}:\
so=${socket}:\
bd=${device}:\
cd=${device}:\
ur=${permission}:\
uw=${permission_write}:\
ux=${permission_exec}:\
ue=${permission_exec}:\
gr=${permission}:\
gw=${permission_write}:\
gx=${permission_exec}:\
tr=${permission}:\
tw=${permission_write}:\
tx=${permission_exec}:\
su=${special}:\
sf=${special}:\
xa=${attribute}:\
sn=${owner}:\
sb=${group}:\
uu=${user}:\
un=${user_none}:\
gu=${group_owner}:\
gn=${group_none}:\
da=${date}:\
in=${inode}:\
lc=${links}:\
lp=${link_path}:\
ga=${git_added}:\
gm=${git_modified}:\
gd=${git_deleted}:\
gv=${git_renamed}:\
gt=${git_typechange}:\
gi=${git_ignored}:\
gc=${git_conflict}:\
hd=${header};1"
	]=], eza_colors)

	return eza
end

return M
