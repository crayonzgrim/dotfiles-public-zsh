local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- packer
	"wbthomason/packer.nvim",

	-- Common utilities. lua functions that many plugins use
	"nvim-lua/plenary.nvim",

	-- theme
	"neanias/everforest-nvim",
	-- {
	-- "svrana/neosolarized.nvim",
	-- requires = { "tjdevries/colorbuddy.nvim" },
	--   }

	-- indent-blankline
	"lukas-reineke/indent-blankline.nvim",

	-- Comment
	{
		"numToStr/Comment.nvim",
		requires = {
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
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	"nvim-telescope/telescope-media-files.nvim",

	-- auto completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip", -- auto completion
	"hrsh7th/vim-vsnip-integ",

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
		config = function()
			-- This is where you modify the settings for lsp-zero
			-- Note: autocompletion settings will not take effect

			require("lsp-zero.settings").preset({
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required (configuring lsp servers)
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required (nvim-cmp source for neovim's built-in LSP)
				{ "hrsh7th/cmp-buffer" }, -- nvim-cmp source for buffer words
				{ "hrsh7th/cmp-path" }, -- source for file system paths
				{ "hrsh7th/cmp-cmdline" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lua" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" }, -- Required
				{ "rafamadriz/friendly-snippets" },
				{ "hrsh7th/vim-vsnip-integ" },
			})
		end,
	},

	-- managing & installing lsp servers
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	"neovim/nvim-lspconfig", -- configuring lsp servers
	"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in LSP
	"nvimdev/lspsaga.nvim", -- LSP UIs
	"onsails/lspkind-nvim", -- vscode-like pictograms

	"jose-elias-alvarez/typescript.nvim", -- renaming, updating .. and so on
	"folke/lsp-colors.nvim",

	-- formatting & linting //  Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",
	"MunifTanjim/prettier.nvim",

	-- bracket auto-pairs & auto-tag
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	-- buffer line
	{ "akinsho/bufferline.nvim", version = "*" },

	-- showex color
	"norcalli/nvim-colorizer.lua",

	-- git
	"lewis6991/gitsigns.nvim",
	"dinhhuy258/git.nvim", -- For git blame & browse
	"tpope/vim-fugitive",
	"kdheepak/lazygit.nvim",
	"sindrets/diffview.nvim",

	-- undo
	{
		{
			"jiaoshijie/undotree",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		},
	},

	-- markdown
	{
		{
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		},
	},
	-- preview
	"rmagatti/goto-preview",

	-- toggle terminal
	{
		{
			"akinsho/toggleterm.nvim",
			version = "*",
		},
	},

	-- multi cursor
	"mg979/vim-visual-multi",

	-- live-server // :LiveServer start // :LiveServer stop
	"barrett-ruth/live-server.nvim",

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
}

local opts = {}

require("lazy").setup(plugins, opts)
