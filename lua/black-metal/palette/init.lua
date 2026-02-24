local M = {}
local Util = require("black-metal.util")

---@enum Themes
M.themes = {
    ["dark-funeral"] = "dark-funeral",
    ["impaled-nazarene"] = "impaled-nazarene",
    bathory = "bathory",
    burzum = "burzum",
    darkthrone = "darkthrone",
    emperor = "emperor",
    gorgoroth = "gorgoroth",
    immortal = "immortal",
    khold = "khold",
    marduk = "marduk",
    mayhem = "mayhem",
    nile = "nile",
    taake = "taake",
    thyrfing = "thyrfing",
    venom = "venom",
    windir = "windir",
}

---Resolve the background color for the spec based on background setting.
---If palette has an explicit alt_bg, use it; otherwise blend toward black.
---@param spec table palette spec
---@param bg_type string "default"|"alt"|"transparent"
local function resolve_bg(spec, bg_type)
    if bg_type == "alt" then
        if spec.alt_bg then
            spec.bg = spec.alt_bg
            spec.line = spec.alt_bg
        else
            spec.bg = Util.blend(spec.bg, 0.75, "#000000")
        end
    elseif bg_type == "transparent" then
        spec.bg = "none"
    end
    -- "default": keep as-is
end

---Build an upstream-compatible base16 table from our colormap.
---@param colormap table our band palette colormap
---@return table
local function colormap_to_base16(colormap)
    return {
        black = colormap.black,
        red = colormap.red,
        green = colormap.green,
        yellow = colormap.yellow,
        blue = colormap.blue,
        magenta = colormap.purple,
        cyan = colormap.cyan,
        white = colormap.white,
        bright_black = colormap.grey,
        bright_red = colormap.orange,
        bright_green = colormap.green,
        bright_yellow = colormap.yellow,
        bright_blue = colormap.blue,
        bright_magenta = colormap.magenta,
        bright_cyan = colormap.cyan,
        bright_white = colormap.white,
    }
end

---Returns the resolved palette for the given theme and background setting.
---@param theme string
---@param bg_type string "default"|"alt"|"transparent"
---@param overrides table? optional color overrides
---@return table { spec: table, base16: table, colormap: table }
M.get = function(theme, bg_type, overrides)
    local raw

    if vim.o.background == "light" then
        raw = require("black-metal.palette.day").get(theme)
    else
        raw = require("black-metal.palette." .. theme)
    end

    -- Apply any user color overrides
    local spec = vim.tbl_extend("force", vim.deepcopy(raw), overrides or {})

    -- Remove non-spec fields
    local colormap = spec.colormap
    spec.colormap = nil

    resolve_bg(spec, bg_type or "default")

    return {
        spec = spec,
        base16 = colormap and colormap_to_base16(colormap) or {},
        colormap = colormap or {},
    }
end

return M
