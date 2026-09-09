local Util = require("black-metal.util")

local M = {}

function M.generate(colors, info)
	colors.extra = info.extra
	colors.url = info.url
	colors.upstream = info.upstream
	colors.theme = info.theme
	local opencode = Util.template(
		[=[
{
	  "$schema": "https://opencode.ai/theme.json",
	  "defs": {
	    "background": "${bg}",
	    "panel": "${alt_bg}",
	    "surface": "${visual}",
	    "text": "${fg}",
	    "muted": "${comment}",
	    "red": "${red}",
	    "green": "${green}",
	    "yellow": "${yellow}",
	    "orange": "${orange}",
	    "blue": "${blue}",
	    "blueBright": "${cyan}",
	    "purple": "${purple}"
	  },
	  "theme": {
	    "primary": "blueBright",
	    "secondary": "blue",
	    "accent": "purple",
	    "error": "red",
	    "warning": "orange",
	    "success": "green",
	    "info": "blue",
	    "text": "text",
	    "textMuted": "muted",
	    "background": "background",
	    "backgroundPanel": "panel",
	    "backgroundElement": "surface",
	    "border": "surface",
	    "borderActive": "blueBright",
	    "borderSubtle": "panel",
	    "diffAdded": "green",
	    "diffRemoved": "red",
	    "diffContext": "muted",
	    "diffHunkHeader": "blue",
	    "diffHighlightAdded": "green",
	    "diffHighlightRemoved": "red",
	    "diffAddedBg": "${green}",
	    "diffRemovedBg": "${red}",
	    "diffContextBg": "panel",
	    "diffLineNumber": "muted",
	    "diffAddedLineNumberBg": "${green}",
	    "diffRemovedLineNumberBg": "${red}",
	    "markdownText": "text",
	    "markdownHeading": "blueBright",
	    "markdownLink": "blue",
	    "markdownLinkText": "blueBright",
	    "markdownCode": "green",
	    "markdownBlockQuote": "muted",
	    "markdownEmph": "orange",
	    "markdownStrong": "yellow",
	    "markdownHorizontalRule": "muted",
	    "markdownListItem": "blue",
	    "markdownListEnumeration": "purple",
	    "markdownImage": "blue",
	    "markdownImageText": "blueBright",
	    "markdownCodeBlock": "text",
	    "syntaxComment": "muted",
	    "syntaxKeyword": "purple",
	    "syntaxFunction": "blueBright",
	    "syntaxVariable": "orange",
	    "syntaxString": "green",
	    "syntaxNumber": "yellow",
	    "syntaxType": "blue",
	    "syntaxOperator": "purple",
	    "syntaxPunctuation": "text"
	  }
}
]=],
		colors
	)
	return opencode
end

return M
