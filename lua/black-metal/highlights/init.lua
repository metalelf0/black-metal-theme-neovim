local M = {}

---@alias Highlight {fg:string, bg:string, sp:string, fmt:string}

---Process fmt string, removing underline/undercurl if config.underline false
---@param fmt string
---@param config black-metal.Config
---@return string
local function process_fmt(fmt, config)
    if type(fmt) ~= "string" then
        return "none"
    end
    if config.underline ~= false or fmt == "none" then
        return fmt
    end
    -- Remove underline and undercurl
    local parts = {}
    for part in fmt:gmatch("[^,%s]+") do
        if part ~= "underline" and part ~= "undercurl" then
            table.insert(parts, part)
        end
    end
    if #parts == 0 then
        return "none"
    end
    return table.concat(parts, ",")
end

---@param highlights table<string,Highlight>
local function vim_highlights(highlights, config)
    for group, hi in pairs(highlights) do
        vim.api.nvim_command(
            string.format(
                "highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
                group,
                hi.fg or "none",
                hi.bg or "none",
                hi.sp or "none",
                process_fmt(hi.fmt, config)
            )
        )
    end
end

---Util for applying custom user colors.
---@param prefix string
---@param color string
---@param palette black-metal.Theme
---@param config black-metal.Config
---@return string
local function overwrite(prefix, color, palette, config)
    if not color then
        return ""
    end
    if color:sub(1, 1) == "$" then
        local name = color:sub(2, -1)
        color = palette[name]
        if not color then
            vim.schedule(function()
                vim.notify(
                    'black-metal.nvim: unknown color "' .. name .. '"',
                    vim.log.levels.ERROR,
                    { title = "black-metal.nvim" }
                )
            end)
            return ""
        end
    end
    if prefix == "gui" then
        color = process_fmt(color, config)
    end
    return prefix .. "=" .. color
end

function M.setup()
	---@type black-metal.Config
	local Config = require("black-metal").options()

	local c = require("black-metal.palette").get(Config.theme, Config.variant)

	local custom_colors = Config.colors

	for label, color in pairs(custom_colors) do
		if label ~= "dark" and label ~= "light" then
			c[label] = color
		end
	end
	for label, color in pairs(custom_colors[Config.variant] or {}) do
		c[label] = color
	end

 local COMMON = require("black-metal.highlights.common").get(c)
    local SYNTAX = require("black-metal.highlights.syntax").get(c)
    local PLUGIN = require("black-metal.highlights.plugin").get(c)

    vim_highlights(COMMON, Config)
    for _, group in pairs(SYNTAX) do
        vim_highlights(group, Config)
    end
    for _, group in pairs(PLUGIN) do
        vim_highlights(group, Config)
    end

	for group, hi in pairs(Config.highlights) do
        vim.api.nvim_command(
            string.format(
                "highlight %s %s %s %s %s",
                group,
                overwrite("guifg", hi.fg, c, Config),
                overwrite("guibg", hi.bg, c, Config),
                overwrite("guisp", hi.sp, c, Config),
                overwrite("gui", hi.fmt, c, Config)
            )
        )
	end
	if Config.favor_treesitter_hl then
		vim.highlight.priorities.semantic_tokens = 95
	end
end

return M
