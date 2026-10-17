local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local helix = Util.template(
		[=[
# name: ${theme} colors for ${extra}
# url: ${url}
# upstream: ${upstream}
# author: Andrea Schiavini (original code by Casey Miller)

# Interface
"ui.background" = { bg = "${bg}" }
"ui.text" = "${fg}"
"ui.text.focus" = { fg = "${alt}", modifiers = ["bold"] }
"ui.text.inactive" = "${comment}"
"ui.text.info" = "${cyan}"
"ui.text.directory" = "${type}"
"ui.cursor" = { fg = "${bg}", bg = "${fg}" }
"ui.cursor.primary" = { fg = "${bg}", bg = "${alt}" }
"ui.cursor.match" = { fg = "${alt}", modifiers = ["bold"] }
"ui.gutter" = { fg = "${comment}", bg = "${bg}" }
"ui.gutter.selected" = { fg = "${fg}", bg = "${line}" }
"ui.linenr" = "${comment}"
"ui.linenr.selected" = { fg = "${alt}", modifiers = ["bold"] }
"ui.statusline" = { fg = "${fg}", bg = "${line}" }
"ui.statusline.inactive" = { fg = "${comment}", bg = "${bg}" }
"ui.statusline.normal" = { fg = "${bg}", bg = "${alt}" }
"ui.statusline.insert" = { fg = "${bg}", bg = "${diag_green}" }
"ui.statusline.select" = { fg = "${bg}", bg = "${diag_blue}" }
"ui.statusline.separator" = "${comment}"
"ui.bufferline" = { fg = "${comment}", bg = "${bg}" }
"ui.bufferline.active" = { fg = "${fg}", bg = "${line}", modifiers = ["bold"] }
"ui.bufferline.background" = { bg = "${bg}" }
"ui.popup" = { fg = "${fg}", bg = "${line}" }
"ui.popup.info" = { fg = "${cyan}", bg = "${line}" }
"ui.window" = { fg = "${comment}" }
"ui.help" = { fg = "${fg}", bg = "${line}" }
"ui.virtual.ruler" = { bg = "${line}" }
"ui.virtual.whitespace" = "${comment}"
"ui.virtual.indent-guide" = "${comment}"
"ui.virtual.inlay-hint" = { fg = "${comment}", modifiers = ["italic"] }
"ui.virtual.wrap" = "${comment}"
"ui.virtual.jump-label" = { fg = "${alt}", modifiers = ["bold"] }
"ui.menu" = { fg = "${fg}", bg = "${line}" }
"ui.menu.selected" = { fg = "${bg}", bg = "${alt}", modifiers = ["bold"] }
"ui.menu.scroll" = { fg = "${alt}", bg = "${line}" }
"ui.selection" = { fg = "${fg}", bg = "${visual}" }
"ui.selection.primary" = { fg = "${fg}", bg = "${alt_bg}" }
"ui.highlight" = { bg = "${line}" }
"ui.cursorline.primary" = { bg = "${line}" }
"ui.cursorcolumn.primary" = { bg = "${line}" }

# Syntax
"attribute" = "${alt}"
"type" = "${type}"
"type.builtin" = "${constant}"
"type.parameter" = "${property}"
"type.enum.variant" = "${alt}"
"constructor" = "${func}"
"constant" = "${constant}"
"constant.builtin" = "${number}"
"constant.character" = "${string}"
"constant.character.escape" = "${keyword}"
"constant.numeric" = "${number}"
"string" = "${string}"
"string.regexp" = "${alt}"
"string.special" = "${alt}"
"string.special.path" = "${string}"
"string.special.url" = { fg = "${cyan}", modifiers = ["underlined"] }
"comment" = { fg = "${comment}", modifiers = ["italic"] }
"comment.documentation" = { fg = "${comment}", modifiers = ["italic"] }
"comment.unused" = { fg = "${comment}", modifiers = ["crossed_out"] }
"variable" = "${fg}"
"variable.builtin" = "${alt}"
"variable.parameter" = "${property}"
"variable.other.member" = "${property}"
"label" = "${alt}"
"punctuation" = "${operator}"
"keyword" = "${keyword}"
"keyword.control" = "${keyword}"
"keyword.directive" = "${alt}"
"keyword.function" = "${func}"
"keyword.storage" = "${alt}"
"operator" = "${operator}"
"function" = "${func}"
"function.builtin" = "${alt}"
"function.method" = "${func}"
"function.macro" = "${keyword}"
"tag" = "${alt}"
"namespace" = "${type}"
"special" = "${alt}"
"markup.heading" = { fg = "${func}", modifiers = ["bold"] }
"markup.heading.marker" = "${comment}"
"markup.list" = "${operator}"
"markup.bold" = { modifiers = ["bold"] }
"markup.italic" = { modifiers = ["italic"] }
"markup.strikethrough" = { modifiers = ["crossed_out"] }
"markup.link.url" = { fg = "${cyan}", modifiers = ["underlined"] }
"markup.link.label" = "${alt}"
"markup.link.text" = "${fg}"
"markup.quote" = "${comment}"
"markup.raw" = "${string}"

# Diagnostics and diff
"warning" = "${diag_yellow}"
"error" = "${diag_red}"
"info" = "${diag_blue}"
"hint" = "${diag_green}"
"diagnostic" = { underline = { color = "${comment}", style = "curl" } }
"diagnostic.hint" = { underline = { color = "${diag_green}", style = "curl" } }
"diagnostic.info" = { underline = { color = "${diag_blue}", style = "curl" } }
"diagnostic.warning" = { underline = { color = "${diag_yellow}", style = "curl" } }
"diagnostic.error" = { underline = { color = "${diag_red}", style = "curl" } }
"diagnostic.unnecessary" = { modifiers = ["dim"] }
"diagnostic.deprecated" = { modifiers = ["crossed_out"] }
"diff.plus" = "${diag_green}"
"diff.plus.gutter" = "${diag_green}"
"diff.minus" = "${diag_red}"
"diff.minus.gutter" = "${diag_red}"
"diff.delta" = "${diag_yellow}"
"diff.delta.gutter" = "${diag_yellow}"
"diff.moved" = "${diag_blue}"
"diff.conflict" = "${orange}"

# Theme palette
[palette]
black = "${black}"
grey = "${grey}"
red = "${red}"
orange = "${orange}"
green = "${green}"
yellow = "${yellow}"
blue = "${blue}"
purple = "${purple}"
magenta = "${magenta}"
cyan = "${cyan}"
white = "${white}"
foreground = "${fg}"
background = "${bg}"
selection = "${visual}"
]=],
		colors
	)
	return helix
end

return M
