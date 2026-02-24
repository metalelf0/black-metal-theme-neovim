local M = {}

local WHITE = "#FFFFFF"
local BLACK = "#000000"

---Translates a hex color to RGB components.
---@param color string hex color code
---@return table
local function hexToRgb(color)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    color = string.lower(color)
    assert(string.find(color, pat) ~= nil, "hexToRgb: invalid color: " .. tostring(color))
    local r, g, b = string.match(color, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---Blend two hex colors. coeff=1 returns a, coeff=0 returns b.
---@param a string foreground hex color
---@param coeff number blend coefficient [0-1]
---@param b string background hex color
---@return string
function M.blend(a, coeff, b)
    local A = hexToRgb(a)
    local B = hexToRgb(b)
    local alpha = math.abs(coeff)
    local blendChannel = function(i)
        local ret = (1 - alpha) * B[i] + alpha * A[i]
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end
    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

---Blend a color toward white (lighten). coeff=1 returns white.
---@param a string hex color
---@param coeff number blend coefficient [0-1]
---@return string
function M.lighten(a, coeff)
    return M.blend(a, coeff, WHITE)
end

---Blend a color toward black (darken). coeff=1 returns black.
---@param a string hex color
---@param coeff number blend coefficient [0-1]
---@return string
function M.darken(a, coeff)
    return M.blend(a, coeff, BLACK)
end

---Generate a light mode variant of a palette by inverting colors via HSLuv.
---@param colors table flat palette table
---@return table
function M.generate_light_variant(colors)
    local hsluv = require("black-metal.hsluv")
    local saturation_coeff = 25e-2
    local brightness_coeff = 1e-4
    local function invert(cname, cval)
        if type(cval) == "table" then
            for k, v in pairs(cval) do
                cval[k] = invert(k, v)
            end
            return cval
        elseif type(cval) == "string" and cval ~= "none" then
            local hsl = hsluv.hex_to_hsluv(cval)
            if cname:find("bg$") and hsl[3] < 50 then
                hsl[3] = 98 - hsl[3]
                hsl[3] = hsl[3] + (98 - hsl[3]) * brightness_coeff
            else
                hsl[2] = hsl[2] + (100 - hsl[2]) * saturation_coeff
                hsl[3] = 100 - hsl[3]
                if hsl[3] < 50 then
                    hsl[3] = hsl[3] + (100 - hsl[3]) * brightness_coeff
                end
            end
            return hsluv.hsluv_to_hex(hsl)
        end
    end
    for k, v in pairs(colors) do
        colors[k] = invert(k, v)
    end
    -- alt_bg is always darker than bg; after inversion they need to be swapped
    colors["bg"], colors["alt_bg"] = colors["alt_bg"], colors["bg"]
    return colors
end

---Generate a string from a template, substituting `${key}` references from a table.
---@param str string template string
---@param tbl table substitution values
---@return string
function M.template(str, tbl)
    return (str:gsub("($%b{})", function(w)
        return vim.tbl_get(tbl, unpack(vim.split(w:sub(3, -2), ".", { plain = true }))) or w
    end))
end

return M
