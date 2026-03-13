local M = {}

function M.get(colors)
	---@type black-metal.Config
	local Config = require("black-metal").options()
	local Util = require("black-metal.util")
	local c = colors

	local hl = {}

	hl.special = {
		LazyNormal = { bg = c.line },
		MasonNormal = { bg = c.line },
	}

	hl.bufferline = {
		BufferLineBufferSelected = { fg = c.string },
	}

	hl.cmp = {
		CmpItemAbbr = { fg = c.fg },
		CmpItemAbbrDeprecated = { fg = c.comment, fmt = "strikethrough" },
		CmpItemAbbrMatch = { fg = c.type },
		CmpItemAbbrMatchFuzzy = { fg = c.type, fmt = "underline" },
		CmpItemMenu = { fg = c.comment },
		CmpItemKind = {
			fg = c.comment,
			fmt = Config.plugin.cmp.reverse and "reverse",
		},
	}

	hl.blink = {
		BlinkCmpKind = {
			fg = c.comment,
			fmt = Config.plugin.cmp.reverse and "reverse",
		},
	}

	hl.diffview = {
		DiffviewFilePanelTitle = { fg = c.func, fmt = "bold" },
		DiffviewFilePanelCounter = { fg = c.alt, fmt = "bold" },
		DiffviewFilePanelFileName = { fg = c.fg },
		DiffviewNormal = { link = "Normal" },
		DiffviewCursorLine = { link = "CursorLine" },
		DiffviewVertSplit = { link = "VertSplit" },
		DiffviewSignColumn = { link = "SignColumn" },
		DiffviewStatusLine = { link = "StatusLine" },
		DiffviewStatusLineNC = { link = "StatusLineNC" },
		DiffviewEndOfBuffer = { link = "EndOfBuffer" },
		DiffviewFilePanelRootPath = { fg = c.comment },
		DiffviewFilePanelPath = { fg = c.comment },
		DiffviewFilePanelInsertions = { fg = c.fg },
		DiffviewFilePanelDeletions = { fg = c.operator },
		DiffviewStatusAdded = { fg = c.fg },
		DiffviewStatusUntracked = { fg = c.diag_blue },
		DiffviewStatusModified = { fg = c.diag_blue },
		DiffviewStatusRenamed = { fg = c.diag_blue },
		DiffviewStatusCopied = { fg = c.diag_blue },
		DiffviewStatusTypeChange = { fg = c.diag_blue },
		DiffviewStatusUnmerged = { fg = c.diag_blue },
		DiffviewStatusUnknown = { fg = c.diag_red },
		DiffviewStatusDeleted = { fg = c.diag_red },
		DiffviewStatusBroken = { fg = c.diag_red },
	}

	hl.gitsigns = {
		GitSignsAdd = { fg = c.diag_green },
		GitSignsAddLn = { fg = c.diag_green },
		GitSignsAddNr = { fg = c.diag_green },
		GitSignsAddCul = { fg = c.diag_green, bg = c.line },
		GitSignsChange = { fg = c.diag_blue },
		GitSignsChangeLn = { fg = c.diag_blue },
		GitSignsChangeNr = { fg = c.diag_blue },
		GitSignsChangeCul = { fg = c.diag_blue, bg = c.line },
		GitSignsDelete = { fg = c.diag_red },
		GitSignsDeleteLn = { fg = c.diag_red },
		GitSignsDeleteNr = { fg = c.diag_red },
		GitSignsDeleteCul = { fg = c.diag_red, bg = c.line },
	}

	hl.neogit = {
		NeogitBranch = { fg = c.alt },
		NeogitUntrackedfiles = { fg = c.diag_blue, fmt = "italic" },
		NeogitUnpulledchanges = { fg = c.diag_blue, fmt = "italic" },
		NeogitUnmergedchanges = { fg = c.keyword, fmt = "bolditalic" },
		NeogitDiffAdd = { link = "DiffAdd" },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffAddCursor = { bg = Util.blend(c.diag_green, 0.2, c.bg) },
		NeogitDiffDelete = { link = "DiffDelete" },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitDiffDeleteCursor = {
			bg = Util.blend(c.diag_red, 0.2, c.bg),
		},
		NeogitDiffContext = { bg = c.line },
		NeogitDiffContextHighlight = { bg = c.line },
		NeogitDiffContextCursor = { bg = c.line },
		NeogitSectionHeader = { fg = c.func },
		NeogitHunkHeader = { fg = c.comment },
		NeogitHunkHeaderHighlight = { fg = c.comment, fmt = "italic" },
		NeogitHunkHeaderCursor = { fg = c.comment, fmt = "bolditalic" },
		NeogitHunkMergeHeader = { fg = c.diag_blue, bg = c.line, fmt = "bold" },
		NeogitHunkMergeHeaderHighlight = {
			fg = c.diag_blue,
			bg = c.line,
			fmt = "italic",
		},
		NeogitHunkMergeHeaderCursor = {
			fg = c.diag_blue,
			bg = c.line,
			fmt = "bolditalic",
		},
	}

	hl.neo_tree = {
		NeoTreeNormal = { fg = c.fg, bg = Config.transparent and nil or c.bg },
		NeoTreeNormalNC = { fg = c.fg, bg = Config.transparent and nil or c.bg },
		NeoTreeVertSplit = {
			fg = c.comment,
			bg = Config.transparent and nil or c.comment,
		},
		NeoTreeWinSeparator = {
			fg = c.comment,
			bg = Config.transparent and nil or c.comment,
		},
		NeoTreeEndOfBuffer = {
			fg = Config.show_eob and c.comment or c.bg,
			bg = Config.transparent and nil or c.bg,
		},
		NeoTreeRootName = { fg = c.type, fmt = "bold" },
		NeoTreeGitAdded = { fg = c.fg },
		NeoTreeGitDeleted = { fg = c.diag_red },
		NeoTreeGitModified = { fg = c.diag_blue },
		NeoTreeGitConflict = { fg = c.diag_red, fmt = "bold,italic" },
		NeoTreeGitUntracked = { fg = c.diag_red, fmt = "italic" },
		NeoTreeIndentMarker = { fg = c.comment },
		NeoTreeSymbolicLinkTarget = { fg = c.diag_blue },
	}

	hl.nvim_tree = {
		NvimTreeNormal = { fg = c.fg, bg = Config.transparent and nil or c.bg },
		NvimTreeVertSplit = {
			fg = c.line,
			bg = Config.transparent and nil or c.bg,
		},
		NvimTreeEndOfBuffer = {
			fg = Config.show_eob and c.comment or c.bg,
			bg = Config.transparent and nil or c.bg,
		},
		NvimTreeRootFolder = { fg = c.type, fmt = "bold" },
		NvimTreeGitDirty = { fg = c.diag_blue },
		NvimTreeGitNew = { fg = c.fg },
		NvimTreeGitDeleted = { fg = c.diag_red },
		NvimTreeSpecialFile = { fg = c.diag_yellow, fmt = "underline" },
		NvimTreeIndentMarker = { fg = c.fg },
		NvimTreeImageFile = { fg = c.visual },
		NvimTreeSymlink = { fg = c.diag_blue },
		NvimTreeFolderName = { fg = c.func },
	}

	hl.obsidian = {
		ObsidianTodo = { link = "@markup.list.unchecked" },
		ObsidianDone = { link = "@markup.list.checked" },
		ObsidianRightArrow = { bold = true, fg = c.fg },
		ObsidianTilde = { bold = true, fg = c.fg },
		ObsidianBullet = { link = "@markup.list" },
		ObsidianRefText = { link = "@markup.link" },
		ObsidianExtLinkIcon = { link = "@markup.strikethrough" },
		ObsidianTag = { link = "@markup.list.unchecked" },
		ObsidianHighlightText = {
			bg = Util.blend(c.constant, 0.1, c.bg),
			fg = c.constant,
		},
	}

	hl.snacks = {
		SnacksDashboardIcon = { fg = c.func },
		SnacksDashboardDesc = { fg = c.func },
		SnacksDashboardFile = { fg = c.alt },
		SnacksDashboardSpecial = { fg = c.type },
	}

	hl.telescope = {
		TelescopeTitle = { fg = c.comment },
		TelescopeBorder = { fg = c.comment },
		TelescopeMatching = { fg = c.type, fmt = "bold" },
		TelescopePromptPrefix = { fg = c.type },
		TelescopeSelection = {
			fg = c.diag_blue,
			bg = Config.transparent and nil or c.line,
		},
		TelescopeSelectionCaret = { fg = c.diag_blue },
		TelescopeResultsNormal = { fg = c.fg },
	}

	hl.dashboard = {
		DashboardShortCut = { fg = c.func },
		DashboardHeader = { fg = c.keyword },
		DashboardCenter = { fg = c.fg },
		DashboardFooter = { fg = c.func, fmt = "italic" },
	}

	hl.ministarter = {
		MiniStarterHeader = { fg = c.keyword },
		MiniStarterFooter = { fg = c.keyword },
	}

	hl.indent_blankline = {
		IndentBlanklineIndent1 = { fg = c.func },
		IndentBlanklineIndent2 = { fg = c.fg },
		IndentBlanklineIndent3 = { fg = c.keyword },
		IndentBlanklineIndent4 = { fg = c.comment },
		IndentBlanklineIndent5 = { fg = c.alt },
		IndentBlanklineIndent6 = { fg = c.operator },
		IndentBlanklineChar = { fg = c.comment, fmt = "nocombine" },
		IndentBlanklineContextChar = { fg = c.comment, fmt = "nocombine" },
		IndentBlanklineContextStart = { sp = c.comment, fmt = "underline" },
		IndentBlanklineContextSpaceChar = { fmt = "nocombine" },
		IblIndent = { fg = c.comment, fmt = "nocombine" },
		IblWhitespace = { fg = c.comment, fmt = "nocombine" },
		IblScope = { fg = c.comment, fmt = "nocombine" },
	}

	if not Config.plugin.cmp.plain then
		local lsp_kind_icons_color = {
			Default = c.keyword,
			Array = c.keyword,
			Boolean = c.func,
			Class = c.type,
			Color = c.fg,
			Constant = c.constant,
			Constructor = c.constant,
			Enum = c.constant,
			EnumMember = c.property,
			Event = c.type,
			Field = c.property,
			File = c.fg,
			Folder = c.func,
			Function = c.func,
			Interface = c.constant,
			Key = c.keyword,
			Keyword = c.keyword,
			Method = c.func,
			Module = c.constant,
			Namespace = c.constant,
			Null = c.type,
			Number = c.func,
			Object = c.type,
			Operator = c.operator,
			Package = c.constant,
			Property = c.property,
			Reference = c.type,
			Snippet = c.type,
			String = c.string,
			Struct = c.keyword,
			Text = c.fg,
			TypeParameter = c.type,
			Unit = c.fg,
			Value = c.fg,
			Variable = c.fg,
		}

		for kind, color in pairs(lsp_kind_icons_color) do
			hl.cmp["CmpItemKind" .. kind] = { fg = color, fmt = Config.plugin.cmp.reverse and "reverse" }
			hl.cmp["BlinkCmpKind" .. kind] = { fg = color, fmt = Config.plugin.cmp.reverse and "reverse" }
		end
	end
	return hl
end

return M
