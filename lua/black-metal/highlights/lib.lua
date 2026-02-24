---@class Highlight
---@field guifg  string?
---@field guibg  string?
---@field guisp  string?
---@field gui    string?
---@field link   string?

local M = {}
local HL_ARGS = { guifg = true, guibg = true, guisp = true, gui = false, link = false }

local function resolve_override(field, is_hex, new, palette)
    if new == nil then
        return nil
    elseif type(new) ~= "string" then
        vim.schedule(function()
            vim.notify(
                string.format("black-metal.nvim: unknown value format for field '%s'", field),
                vim.log.levels.WARN
            )
        end)
        return nil
    end

    -- For 'gui' | 'link', assume value is correct. See `:h highlight-args`.
    if not is_hex then
        return new
    end

    -- Accept hex code literals
    if new:sub(1, 1) == "#" then
        return new
    end

    -- Resolve palette color references like "$keyword"
    if new:sub(1, 1) == "$" then
        local color_name = new:sub(2)
        local hex = palette[color_name]
        if hex then
            return hex
        end
    end

    vim.schedule(function()
        vim.notify(
            string.format("black-metal.nvim: unknown color or format -- '%s=%s'", field, new),
            vim.log.levels.WARN
        )
    end)
    return nil
end

---Overwrite a highlight definition with user overrides, resolving palette references.
---@param default Highlight
---@param new Highlight
---@param palette table palette spec
---@return Highlight
M.overwrite = function(default, new, palette)
    local result = {}
    for field, is_hex in pairs(HL_ARGS) do
        result[field] = resolve_override(field, is_hex, new[field], palette) or default[field]
    end
    return result
end

---Resolve a legacy fg/bg/sp color string (may be "$key" reference) for use in a highlight command.
---@param prefix string e.g. "guifg"
---@param color string hex or "$key" reference
---@param palette table palette spec
---@return string e.g. "guifg=#aabbcc"
M.resolve_color = function(prefix, color, palette)
    if not color then
        return ""
    end
    if color:sub(1, 1) == "$" then
        local name = color:sub(2)
        color = palette[name]
        if not color then
            vim.schedule(function()
                vim.notify(
                    string.format('black-metal.nvim: unknown color "$%s"', name),
                    vim.log.levels.WARN
                )
            end)
            return ""
        end
    end
    return prefix .. "=" .. color
end

---Format a highlight definition as a vim highlight command string.
---@param group string highlight group name
---@param hl Highlight highlight definition
---@return string
M.to_str = function(group, hl)
    if hl.link ~= nil then
        return string.format("highlight link %s %s", group, hl.link)
    end

    local parts = vim.iter(HL_ARGS)
        :filter(function(field)
            return field ~= "link" and hl[field] ~= nil
        end)
        :map(function(field)
            return string.format("%s=%s", field, hl[field])
        end)
        :totable()

    return string.format("highlight %s %s", group, table.concat(parts, " "))
end

return M
