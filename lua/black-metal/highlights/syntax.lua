local M = {}

function M.get(colors)
	---@type black-metal.Config
	local Config = require("black-metal").options()
	local Util = require("black-metal.util")
	local c = colors
	local hl = {}

	local syntax = {
		Boolean = { fg = c.number }, -- boolean constants
		Character = { fg = c.string }, -- character constants
		Comment = { fg = c.comment, fmt = Config.code_style.comments }, -- comments
		Constant = { fg = c.constant, fmt = Config.code_style.constants }, -- (preferred) any constant
		Delimiter = { fg = c.fg }, -- delimiter characters
		Float = { fg = c.number }, -- float constants
		Function = { fg = c.func, fmt = Config.code_style.functions }, -- functions
		Error = { fg = c.diag_red }, -- (preferred) any erroneous construct
		Exception = { fg = c.diag_red }, -- 'try', 'catch', 'throw'
		Identifier = { fg = c.property, fmt = Config.code_style.variables }, -- (preferred) any variable
		Keyword = { fg = c.keyword, fmt = Config.code_style.keywords }, -- any other keyword
		Conditional = { fg = c.keyword, fmt = Config.code_style.conditionals }, -- conditionals
		-- Repeat = { fg = c.keyword, fmt = config.code_style.keywords }, -- loop keywords: 'for', 'while' etc
		-- Label = { fg = c.keyword }, -- 'case', 'default', etc
		Number = { fg = c.number }, -- number constant
		Operator = { fg = c.operator, fmt = Config.code_style.operators }, -- '+', '*', 'sizeof' etc
		PreProc = { fg = c.string }, -- (preferred) generic preprocessor
		-- Define = { fg = c.comment }, -- preprocessor '#define'
		Include = { fg = c.constant, fmt = Config.code_style.keywords }, -- preprocessor '#include'
		Macro = { fg = c.number, fmt = "italic" }, -- macros
		-- PreCondit = { fg = c.comment }, -- preprocessor conditionals '#if', '#endif' etc
		Special = { fg = c.type }, -- (preferred) any special symbol
		SpecialChar = { fg = c.keyword }, -- special character in a constant
		-- SpecialComment = { fg = c.keyword, fmt = config.code_style.comments }, -- special things inside comments
		-- Tag = { fg = c.func }, -- can use <C-]> on this
		Statement = { fg = c.keyword }, -- (preferred) any statement
		String = { fg = c.string, fmt = Config.code_style.strings }, -- string constants
		Title = { fg = c.keyword },
		Type = { fg = c.type }, -- (preferred) 'int', 'long', 'char' etc
		-- StorageClass = { fg = c.constant, fmt = config.code_style.keywords }, -- 'static', 'volatile' etc
		-- Structure = { fg = c.constant }, -- 'struct', 'union', 'enum' etc
		-- Typedef = { fg = c.constant }, -- 'typedef'
		Todo = { fg = Util.blend(c.comment, 0.6, c.fg), fmt = "bolditalic" }, -- (preferred) 'TODO' keywords in comments
	}

	local treesitter = vim.version()["minor"] > 0.8
			and {
				-- identifiers
				["@variable"] = { fg = c.fg, fmt = Config.code_style.variables }, -- any variable that does not have another higM.ght
				["@variable.builtin"] = syntax["Type"], -- variable names that are defined by the language, like 'this' or 'self'
				["@variable.member"] = { fg = c.property }, -- fields
				["@variable.parameter"] = { fg = c.alt }, -- parameters of a function
				-- ["@variable.field"] = { fg = c.property }, -- fields

				-- ["@constant"] = { link = "Constant" }, -- constants
				["@constant.builtin"] = syntax["Type"], -- constants that are defined by the language, like 'nil' in lua
				-- ["@constant.macro"] = { link = "Macro" }, -- constants that are defined by macros like 'NULL' in c

				-- ["@label"] = { link = "Label" }, -- labels
				["@module"] = syntax["Type"], -- modules and namespaces

				-- literals
				-- ["@string"] = { link = "String" }, -- strings
				["@string.documentation"] = Config.colored_docstrings and syntax["String"] or syntax["Comment"], -- doc strings
				["@string.regexp"] = syntax["SpecialChar"], -- regex
				["@string.escape"] = syntax["SpecialChar"], -- escape characters within string
				["@string.special.symbol"] = syntax["String"],
				-- ["@string.special.symbol"] = syntax["Identifier"],
				-- ["@string.special.url"] = { fg = c.func }, -- urls, links, emails

				-- ["@character"] = { link = "String" }, -- character literals
				-- ["@character.special"] = M.syntax["SpecialChar"], -- special characters

				-- ["@boolean"] = { link = "Constant" }, -- booleans
				-- ["@number"] = { link = "Number" }, -- all numbers
				-- ["@number.float"] = { link = "Number" }, -- floats

				-- types
				["@type"] = syntax["Type"], -- types
				-- ["@type.builtin"] = M.syntax["Type"], --builtin types
				-- ["@type.definition"] = M.syntax["Typedef"], -- typedefs
				-- ["@type.qualifier"]

				["@attribute"] = syntax["Function"], -- attributes, like <decorators> in python
				-- ["@property"] = { fg = c.property }, --same as TSField

				-- functions
				["@function"] = syntax["Function"], -- functions
				["@function.builtin"] = syntax["Function"], --builtin functions
				-- ["@function.macro"] = { link = "Macro" }, -- macro defined functions
				-- ["@function.call"]
				-- ["@function.method"]
				-- ["@function.method.call"]

				-- ["@constructor"] = { fg = c.constant, fmt = config.code_style.functions }, -- constructor calls and definitions
				["@constructor.lua"] = {
					fg = c.alt,
					fmt = Config.code_style.functions,
				}, -- constructor calls and definitions, `= { }` in lua
				["@operator"] = syntax["Operator"], -- operators, like `+`

				-- keywords
				["@keyword"] = { fg = c.keyword, fmt = Config.code_style.keywords }, -- keywords that don't fall in previous categories
				["@keyword.exception"] = syntax["Exception"], -- exception related keywords
				-- ["@keyword.import"] = M.syntax["PreProc"], -- keywords used to define a function
				["@keyword.conditional"] = {
					fg = c.keyword,
					fmt = Config.code_style.conditionals,
				}, -- keywords for conditional statements
				["@keyword.operator"] = {
					fg = c.keyword,
					fmt = Config.code_style.operators,
				}, -- keyword operator (eg, 'in' in python)
				["@keyword.return"] = {
					fg = c.keyword,
					fmt = Config.code_style.keyword_return,
				}, -- keywords used to define a function
				-- ["@keyword.function"] = M.syntax["Function"], -- keywords used to define a function
				-- ["@keyword.import"] = M.syntax["Include"], -- includes, like '#include' in c, 'require' in lua
				-- ["@keyword.storage"] = M.syntax["StorageClass"], -- visibility/life-time 'static'
				-- ["@keyword.repeat"] = M.syntax["Repeat"], -- for keywords related to loops

				-- punctuation
				["@punctuation.delimiter"] = { fg = c.fg }, -- delimiters, like `; . , `
				["@punctuation.bracket"] = {
					fg = c.alt,
				}, -- brackets and parentheses
				["@punctuation.special"] = syntax["SpecialChar"], -- punctuation that does not fall into above categories, like `{}` in string interpolation

				-- comment
				-- ["@comment"]
				["@comment.error"] = {
					fg = Util.blend(c.comment, 0.4, c.diag_red),
					fmt = "bolditalic",
				},
				["@comment.warning"] = {
					fg = Util.blend(c.comment, 0.4, c.diag_yellow),
					fmt = "bolditalic",
				},
				["@comment.note"] = {
					fg = Util.blend(c.comment, 0.4, c.diag_blue),
					fmt = "bolditalic",
				},

				-- markup
				["@markup"] = { fg = c.fg }, -- text in markup language
				["@markup.strong"] = { fg = c.fg, fmt = "bold" }, -- bold
				["@markup.italic"] = { fg = c.fg, fmt = "italic" }, -- italic
				["@markup.underline"] = { fg = c.fg, fmt = "underline" }, -- underline
				["@markup.strikethrough"] = {
					fg = c.comment,
					fmt = "strikethrough",
				}, -- strikethrough
				["@markup.heading"] = {
					fg = c.keyword,
					fmt = Config.code_style.headings,
				}, -- markdown titles
				["@markup.quote.markdown"] = { fg = c.comment }, -- quotes with >
				["@markup.link.uri"] = { fg = c.alt, fmt = "underline" }, -- urls, links, emails
				["@markup.link"] = { fg = c.type }, -- text references, footnotes, citations, etc
				["@markup.list"] = { fg = c.func },
				["@markup.list.checked"] = { fg = c.func }, -- todo checked
				["@markup.list.unchecked"] = { fg = c.func }, -- todo unchecked
				["@markup.raw"] = { fg = c.func }, -- inline code in markdown
				["@markup.math"] = { fg = c.type }, -- math environments, like `$$` in latex

				-- diff
				["@diff.plus"] = { fg = c.diag_green }, -- added text (diff files)
				["@diff.minus"] = { fg = c.diag_red }, -- removed text (diff files)
				["@diff.delta"] = { fg = c.diag_blue }, -- changed text (diff files)

				-- tags
				-- ["@tag"]
				["@tag.attribute"] = syntax["Identifier"], -- tags, like in html
				["@tag.delimiter"] = { fg = c.fg }, -- tag delimiter < >
			}
		or nil

	hl.lsp = vim.version()["minor"] > 0.9
			and {
				["@lsp.typemod.variable.global"] = {
					fg = Util.blend(c.constant, 0.8, c.bg),
				},
				["@lsp.typemod.keyword.documentation"] = {
					fg = Util.blend(c.type, 0.8, c.bg),
				},
				["@lsp.type.namespace"] = {
					fg = Util.blend(c.constant, 0.8, c.bg),
				},
				["@lsp.type.macro"] = syntax["Macro"],
				["@lsp.type.parameter"] = treesitter["@variable.parameter"],
				["@lsp.type.lifetime"] = { fg = c.type, fmt = "italic" },
				["@lsp.type.readonly"] = { fg = c.constant, fmt = "italic" },
				["@lsp.mod.readonly"] = { fg = c.constant, fmt = "italic" },
				["@lsp.mod.typeHint"] = syntax["Type"],
			}
		or nil
	hl.diag = {
		DiagnosticError = { fg = c.diag_red },
		DiagnosticHint = { fg = c.diag_blue },
		DiagnosticInfo = { fg = c.diag_blue, fmt = "italic" },
		DiagnosticWarn = { fg = c.diag_yellow },

		DiagnosticVirtualTextError = {
			bg = Config.diagnostics.background and Util.blend(c.diag_red, 0.1, c.bg) or nil,
			fg = c.diag_red,
		},
		DiagnosticVirtualTextWarn = {
			bg = Config.diagnostics.background and Util.blend(c.diag_yellow, 0.1, c.bg) or nil,
			fg = c.diag_yellow,
		},
		DiagnosticVirtualTextInfo = {
			bg = Config.diagnostics.background and Util.blend(c.diag_blue, 0.1, c.bg) or nil,
			fg = c.diag_blue,
		},
		DiagnosticVirtualTextHint = {
			bg = Config.diagnostics.background and Util.blend(c.diag_blue, 0.1, c.bg) or nil,
			fg = c.diag_blue,
		},

		DiagnosticUnderlineError = {
			fmt = Config.diagnostics.undercurl and "undercurl" or "underline",
			sp = c.diag_red,
		},
		DiagnosticUnderlineHint = {
			fmt = Config.diagnostics.undercurl and "undercurl" or "underline",
			sp = c.diag_blue,
		},
		DiagnosticUnderlineInfo = {
			fmt = Config.diagnostics.undercurl and "undercurl" or "underline",
			sp = c.diag_blue,
		},
		DiagnosticUnderlineWarn = {
			fmt = Config.diagnostics.undercurl and "undercurl" or "underline",
			sp = c.diag_yellow,
		},

		LspReferenceText = { bg = c.visual },
		LspReferenceWrite = { bg = c.visual },
		LspReferenceRead = { bg = c.visual },

		LspCodeLens = {
			fg = c.keyword,
			bg = Util.blend(c.keyword, 0.1, c.bg),
			fmt = Config.code_style.comments,
		},
		LspCodeLensSeparator = { fg = c.comment },
	}
	hl.LspDiagnosticsDefaultError = hl.DiagnosticError
	hl.LspDiagnosticsDefaultHint = hl.DiagnosticHint
	hl.LspDiagnosticsDefaultInformation = hl.DiagnosticInfo
	hl.LspDiagnosticsDefaultWarning = hl.DiagnosticWarn
	hl.LspDiagnosticsUnderlineError = hl.DiagnosticUnderlineError
	hl.LspDiagnosticsUnderlineHint = hl.DiagnosticUnderlineHint
	hl.LspDiagnosticsUnderlineInformation = hl.DiagnosticUnderlineInfo
	hl.LspDiagnosticsUnderlineWarning = hl.DiagnosticUnderlineWarn
	hl.LspDiagnosticsVirtualTextError = hl.DiagnosticVirtualTextError
	hl.LspDiagnosticsVirtualTextWarning = hl.DiagnosticVirtualTextWarn
	hl.LspDiagnosticsVirtualTextInformation = hl.DiagnosticVirtualTextInfo
	hl.LspDiagnosticsVirtualTextHint = hl.DiagnosticVirtualTextHint
	hl.syntax = syntax
	hl.treesitter = treesitter

	return hl
end

return M
