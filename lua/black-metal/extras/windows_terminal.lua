local Util = require("black-metal.util")

local M = {}

function M.generate(colors, _)
    local windows_terminal = Util.template(
        [=[
# Add the following object to your Windows Terminal configuration
# https://learn.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes#creating-your-own-color-scheme
{
    "background": "${bg}", // alternate, darker background=${alt_bg}
    "black": "${black}",
    "blue": "${blue}",
    "brightBlack": "${grey}",
    "brightBlue": "${blue}",
    "brightCyan": "${cyan}",
    "brightGreen": "${green}",
    "brightPurple": "${magenta}",
    "brightRed": "${red}",
    "brightWhite": "${fg}",
    "brightYellow": "${yellow}",
    "cursorColor": "${fg}",
    "cyan": "${cyan}",
    "foreground": "${fg}",
    "green": "${green}",
    "name": "${_style_name}",
    "purple": "${purple}",
    "red": "${red}",
    "selectionBackground": "${visual}",
    "white": "${fg}",
    "yellow": "${yellow}"
}
]=],
        colors
    )

    return windows_terminal
end

return M
