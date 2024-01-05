local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugins = {
	-- packer
	"wbthomason/packer.nvim",

	-- Common utilities. lua functions that many plugins use
	"nvim-lua/plenary.nvim",

	-- theme
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	-- {
	-- 	"svrana/neosolarized.nvim",
	-- 	dependencies = { "tjdevries/colorbuddy.nvim" },
	-- },

	-- indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = {},
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- explorer files
	{
		"nvim-tree/nvim-tree.lua",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
	},

	-- icons
	"kyazdani42/nvim-web-devicons",

	-- statusline
	"nvim-lualine/lualine.nvim",

	-- telescope file find
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"kyazdani42/nvim-web-devicons",
		},
	},
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope-media-files.nvim",

	-- auto completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",

	-- snippets
	"rafamadriz/friendly-snippets",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",

	-- emmet
	"mattn/emmet-vim",

	-- lsp-zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = { border = "rounded" },
				},
			},
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" },

			-- cmp
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			local lsp = require("lsp-zero")

			lsp.preset("recommended")

			lsp.ensure_installed({
				"tsserver",
				"lua_ls",
				"eslint_d",
			})

			-- Fix Undefined global 'vim'
			lsp.configure("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
		-- config = function()
		-- 	require("lsp-zero.settings").preset({
		-- 		-- LSP Support
		-- 		{
		-- 			"neovim/nvim-lspconfig",
		-- 			event = { "BufReadPre", "BufNewFile" },
		-- 			dependencies = {
		-- 				"hrsh7th/cmp-nvim-lsp",
		-- 				{ "antosha417/nvim-lsp-file-operations", config = true },
		-- 			},
		-- 			opts = {
		-- 				servers = {
		-- 					tailwindcss = {},
		-- 				},
		-- 			},
		-- 		}, -- Required (configuring lsp servers)
		-- 		{
		-- 			"williamboman/mason.nvim",
		-- 			dependencies = {
		-- 				"williamboman/mason-lspconfig.nvim",
		-- 			},
		-- 		},
		--
		-- 		-- Autocompletion
		-- 		{
		-- 			"hrsh7th/nvim-cmp",
		-- 			dependencies = {
		-- 				{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		-- 			},
		-- 			opts = function(_, opts)
		-- 				local format_kinds = opts.formatting.format
		-- 				opts.formatting.format = function(entry, item)
		-- 					format_kinds(entry, item) -- add icons
		-- 					return require("tailwindcss-colorizer-cmp").formatter(entry, item)
		-- 				end
		-- 			end,
		-- 		}, -- Required
		-- 		{ "hrsh7th/cmp-nvim-lsp" }, -- Required (nvim-cmp source for neovim's built-in LSP)
		-- 		{ "hrsh7th/cmp-buffer" }, -- nvim-cmp source for buffer words
		-- 		{ "hrsh7th/cmp-path" }, -- source for file system paths
		-- 		{ "hrsh7th/cmp-cmdline" },
		--
		-- 		-- Snippets
		-- 		{ "L3MON4D3/LuaSnip" }, -- Required
		-- 	})
		-- end,
	},

	-- managing & installing lsp servers
	-- "williamboman/mason.nvim",
	-- "williamboman/mason-lspconfig.nvim",

	-- "neovim/nvim-lspconfig", -- configuring lsp servers
	-- "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in LSP
	"nvimdev/lspsaga.nvim", -- LSP UIs
	"onsails/lspkind-nvim", -- vscode-like pictograms

	"jose-elias-alvarez/typescript.nvim", -- renaming, updating .. and so on
	"folke/lsp-colors.nvim",

	-- formatting & linting //  Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
	"MunifTanjim/prettier.nvim",

	-- bracket auto-pairs & auto-tag
	"windwp/nvim-ts-autotag",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},

	-- buffer line
	{ "akinsho/bufferline.nvim", version = "*" },

	-- showex color
	{
		"NvChad/nvim-colorizer.lua",
	},
	"ap/vim-css-color",

	-- git
	"lewis6991/gitsigns.nvim",
	"dinhhuy258/git.nvim", -- For git blame & browse
	"tpope/vim-fugitive",
	"kdheepak/lazygit.nvim",
	"sindrets/diffview.nvim",

	-- undo
	{
		"jiaoshijie/undotree",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- preview
	"rmagatti/goto-preview",

	-- toggle terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
	},

	-- multi cursor
	"mg979/vim-visual-multi",

	-- live-server // :LiveServer start // :LiveServer stop
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
	},

	-- maximizer
	"szw/vim-maximizer",
	"christoomey/vim-tmux-navigator",

	-- hop
	{
		{ "phaazon/hop.nvim", branch = "v2" },
	},

	-- codeium
	"Exafunction/codeium.vim",

	-- color-picker
	"ziontee113/color-picker.nvim",

	"ThePrimeagen/harpoon",

	"folke/todo-comments.nvim",
	"axelvc/template-string.nvim",

	-- remember and open last file
	"tpope/vim-obsession",
	{
		"dhruvasagar/vim-prosession",
		dependencies = { { "tpope/vim-obsession" } },
	},

	"anuvyklack/hydra.nvim",

	{
		"stevearc/oil.nvim",
		opt = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- },
}

local opts = {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
}

require("lazy").setup(plugins, opts)
