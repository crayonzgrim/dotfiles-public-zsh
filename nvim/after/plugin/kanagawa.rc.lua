local status, kanagawa = pcall(require, "kanagawa")
if not status then
	return
end

-- Default options:
kanagawa.setup({
	...,
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	transparent = true,
	dimInactive = false,
	terminalColors = true,
	theme = "dragon",
	overrides = function(colors)
		local theme = colors.theme
		return {
			LineNr = { bg = "none" },
			-- telescope
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg },
			TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
			TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
			TelescopePreviewNormal = { bg = theme.ui.bg },
			TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
			-- popup menus
			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		}
	end,
	-- compile = false, -- enable compiling the colorscheme
	-- undercurl = true, -- enable undercurls
	-- commentStyle = { italic = true },
	-- functionStyle = {},
	-- keywordStyle = { italic = true },
	-- statementStyle = { bold = true },
	-- typeStyle = {},
	-- transparent = true, -- do not set background color
	-- dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- colors = { -- add/modify theme and palette colors
	-- 	palette = {},
	-- 	theme = {
	-- 		wave = {},
	-- 		lotus = {},
	-- 		dragon = {},
	-- 		all = {
	-- 			ui = {
	-- 				bg_gutter = "none",
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- overrides = function(colors) -- add/modify highlights
	-- 	return {}
	-- end,
	-- theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- background = { -- map the value of 'background' option to a theme
	-- 	dark = "wave", -- try "dragon" !
	-- 	light = "lotus",
	-- },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
