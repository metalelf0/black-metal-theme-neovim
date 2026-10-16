local Util = require("black-metal.util")

local M = {}

---Blends foreground into background by amount, returning a #RRGGBB color.
---@param foreground string #RRGGBB color to blend in
---@param background string #RRGGBB color to blend over
---@param amount number blend ratio from 0 (background) to 1 (foreground)
---@return string
function M.blend(foreground, background, amount)
	assert(type(amount) == "number" and amount >= 0 and amount <= 1, "amount must be between 0 and 1")
	return Util.blend(foreground, amount, background)
end

return M
