local Util = require("black-metal.util")

local M = {}

local palette_keys = {
	directory = "func",
	executable = "green",
	file = "fg",
	link = "cyan",
	orphan = "diag_red",
	pipe = "purple",
	socket = "cyan",
	device = "yellow",
	special_kind = "orange",
	mount = "cyan",
	permission = "yellow",
	permission_write = "diag_red",
	permission_exec = "green",
	special = "diag_red",
	attribute = "comment",
	size_number = "fg",
	size_unit = "grey",
	size_major = "grey",
	size_minor = "fg",
	user = "yellow",
	user_root = "diag_red",
	user_none = "grey",
	group_owner = "func",
	group_none = "grey",
	links = "comment",
	git_added = "green",
	git_modified = "blue",
	git_deleted = "diag_red",
	git_renamed = "cyan",
	git_typechange = "yellow",
	git_ignored = "dim",
	git_conflict = "orange",
	branch_main = "comment",
	branch_other = "purple",
	git_clean = "green",
	git_dirty = "orange",
	context = "grey",
	context_sep = "comment",
	type_image = "yellow",
	type_video = "purple",
	type_music = "green",
	type_lossless = "cyan",
	type_crypto = "grey",
	type_document = "fg",
	type_compressed = "orange",
	type_temp = "grey",
	type_compiled = "blue",
	type_source = "func",
	punctuation = "comment",
	date = "comment",
	inode = "dim",
	blocks = "comment",
	header = "fg",
	octal = "cyan",
	flags = "cyan",
	link_path = "cyan",
	control_char = "blue",
	broken_path_overlay = "dim",
}

function M.generate(colors, info)
	local eza_colors = {
		theme = info.theme,
		theme_slug = info.theme_slug or info.theme:lower(),
		extra = info.extra,
		url = info.url,
		upstream = info.upstream,
	}
	for key, name in pairs(palette_keys) do
		local hex = colors[name]
		assert(type(hex) == "string" and hex:match("^#%x%x%x%x%x%x$"), "invalid hex color for " .. key .. ": " .. tostring(hex))
		eza_colors[key] = hex
	end

	local eza = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)
#
# Install: copy this file to ~/.config/eza/theme.yml (requires eza >= 0.19.2).
#   Unset EZA_COLORS: it overrides theme.yml.

filekinds:
  normal: {foreground: "${file}"}
  directory: {foreground: "${directory}", is_bold: true}
  symlink: {foreground: "${link}"}
  pipe: {foreground: "${pipe}"}
  block_device: {foreground: "${device}"}
  char_device: {foreground: "${device}"}
  socket: {foreground: "${socket}"}
  special: {foreground: "${special_kind}"}
  executable: {foreground: "${executable}"}
  mount_point: {foreground: "${mount}"}

perms:
  user_read: {foreground: "${permission}"}
  user_write: {foreground: "${permission_write}"}
  user_execute_file: {foreground: "${permission_exec}"}
  user_execute_other: {foreground: "${permission_exec}"}
  group_read: {foreground: "${permission}"}
  group_write: {foreground: "${permission_write}"}
  group_execute: {foreground: "${permission_exec}"}
  other_read: {foreground: "${permission}"}
  other_write: {foreground: "${permission_write}"}
  other_execute: {foreground: "${permission_exec}"}
  special_user_file: {foreground: "${special}"}
  special_other: {foreground: "${special}"}
  attribute: {foreground: "${attribute}"}

size:
  major: {foreground: "${size_major}"}
  minor: {foreground: "${size_minor}"}
  number_byte: {foreground: "${size_number}"}
  number_kilo: {foreground: "${size_number}"}
  number_mega: {foreground: "${size_number}"}
  number_giga: {foreground: "${size_number}"}
  number_huge: {foreground: "${size_number}"}
  unit_byte: {foreground: "${size_unit}"}
  unit_kilo: {foreground: "${size_unit}"}
  unit_mega: {foreground: "${size_unit}"}
  unit_giga: {foreground: "${size_unit}"}
  unit_huge: {foreground: "${size_unit}"}

users:
  user_you: {foreground: "${user}"}
  user_root: {foreground: "${user_root}"}
  user_other: {foreground: "${user_none}"}
  group_yours: {foreground: "${group_owner}"}
  group_other: {foreground: "${group_none}"}
  group_root: {foreground: "${user_root}"}

links:
  normal: {foreground: "${links}"}
  multi_link_file: {foreground: "${links}"}

git:
  new: {foreground: "${git_added}"}
  modified: {foreground: "${git_modified}"}
  deleted: {foreground: "${git_deleted}"}
  renamed: {foreground: "${git_renamed}"}
  typechange: {foreground: "${git_typechange}"}
  ignored: {foreground: "${git_ignored}"}
  conflicted: {foreground: "${git_conflict}"}

git_repo:
  branch_main: {foreground: "${branch_main}"}
  branch_other: {foreground: "${branch_other}"}
  git_clean: {foreground: "${git_clean}"}
  git_dirty: {foreground: "${git_dirty}"}

security_context:
  colon: {foreground: "${context_sep}"}
  user: {foreground: "${context}"}
  role: {foreground: "${context}"}
  typ: {foreground: "${context}"}
  range: {foreground: "${context}"}

file_type:
  image: {foreground: "${type_image}"}
  video: {foreground: "${type_video}"}
  music: {foreground: "${type_music}"}
  lossless: {foreground: "${type_lossless}"}
  crypto: {foreground: "${type_crypto}"}
  document: {foreground: "${type_document}"}
  compressed: {foreground: "${type_compressed}"}
  temp: {foreground: "${type_temp}"}
  compiled: {foreground: "${type_compiled}"}
  source: {foreground: "${type_source}"}

punctuation: {foreground: "${punctuation}"}
date: {foreground: "${date}"}
inode: {foreground: "${inode}"}
blocks: {foreground: "${blocks}"}
header: {foreground: "${header}", is_bold: true}
octal: {foreground: "${octal}"}
flags: {foreground: "${flags}"}

symlink_path: {foreground: "${link_path}"}
control_char: {foreground: "${control_char}"}
broken_symlink: {foreground: "${orphan}"}
broken_path_overlay: {foreground: "${broken_path_overlay}"}
]=],
		eza_colors
	)

	return eza
end

return M
