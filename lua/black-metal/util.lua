local M = {}

---Translates color from HTML to RGB.
---@param color string hex color code
---@return table
local function hexToRgb(color)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    color = string.lower(color)

    assert(
        string.find(color, pat) ~= nil,
        "hex_to_rgb: invalid hex_str: " .. tostring(color)
    )

    local r, g, b = string.match(color, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---Util for blending colors. Alpha coefficeint should be between [0-1]
---where 0=b and 1=a.
---@param a string foreground color in hex
---@param b string background color in hex
---@param coeff number blend coefficient
---@return string
function M.blend(a, coeff, b)
    local A = hexToRgb(a)
    local B = hexToRgb(b)
    local alpha = math.abs(coeff)

    local blendChannel = function(i)
        local ret = ((1 - alpha) * B[i] + alpha * A[i])
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format(
        "#%02X%02X%02X",
        blendChannel(1),
        blendChannel(2),
        blendChannel(3)
    )
end

---Converts a color to its CIE L* lightness (0=black, 100=white).
---@param color string hex color code
---@return number
function M.lightness(color)
    local function linear(channel)
        channel = channel / 255
        return channel <= 0.04045 and channel / 12.92 or ((channel + 0.055) / 1.055) ^ 2.4
    end

    local rgb = hexToRgb(color)
    local y = 0.2126 * linear(rgb[1]) + 0.7152 * linear(rgb[2]) + 0.0722 * linear(rgb[3])
    return y > 0.008856 and 116 * y ^ (1 / 3) - 16 or 903.3 * y
end

---Moves `color` towards `mix` until it is at least `amount` L* apart from
---`background`, keeping the direction in which it stands out from `reference`.
---Returns `color` untouched when it is already far enough.
---@param color string color to separate (e.g. a selection background)
---@param background string background it must stay visible on
---@param reference string color the intended separation is measured against
---@param mix string color to blend towards
---@param amount number minimal L* separation
---@return string
function M.separate(color, background, reference, mix, amount)
    local direction = M.lightness(color) >= M.lightness(reference) and 1 or -1
    local current = color
    for step = 0, 50 do
        if (M.lightness(current) - M.lightness(background)) * direction >= amount then
            return current
        end
        current = M.blend(color, 1 - (step + 1) * 0.02, mix)
    end
    return current
end

---Generates a template from a string containing variables of the form $VAR, and a table
---of corresponding replacement variables.
---
---SOURCE: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
---@param str string template string
---@param table table key value pairs to replace in the string
---@return string
function M.template(str, table)
    return (
        str:gsub("($%b{})", function(w)
            return vim.tbl_get(
                table,
                unpack(vim.split(w:sub(3, -2), ".", { plain = true }))
            ) or w
        end)
    )
end

return M
