local M = {}
local Util = require("black-metal.util")

function M.generate(colors, _)
    return Util.template(
        [=[
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
--color=fg:${fg},bg:${bg},hl:${type},gutter:${bg}
--color=fg+:${property},bg+:${line},hl+:${type}
--color=info:${comment},prompt:${type},pointer:${property}
--color=marker:${keyword},spinner:${keyword},header:${keyword}"

# with alternate, darker background = '${alt_bg}'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
--color=fg:${fg},bg:${alt_bg},hl:${type},gutter:${alt_bg}
--color=fg+:${property},bg+:${line},hl+:${type}
--color=info:${comment},prompt:${type},pointer:${property}
--color=marker:${keyword},spinner:${keyword},header:${keyword}"
  ]=],
        colors
    )
end

return M
