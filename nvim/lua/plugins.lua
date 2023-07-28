local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- Common utilities. lua functions that many plugins use
	use("nvim-lua/plenary.nvim")

	-- theme
	use({ "rose-pine/neovim", as = "rose-pine" })
	-- use({
	-- 	"svrana/neosolarized.nvim",
	-- 	requires = { "tjdevries/colorbuddy.nvim" },
	-- })
	-- use({ "catppuccin/nvim", as = "catppuccin" })

	-- indent-blankline
	use("lukas-reineke/indent-blankline.nvim")

	-- Comment
	use({
		"numToStr/Comment.nvim",
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	})

	-- explorer files
	use({
		"nvim-tree/nvim-tree.lua",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use("kyazdani42/nvim-web-devicons") -- icons

	use("nvim-lualine/lualine.nvim") -- statusline

	-- telescope file find
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- auto completion
	use("hrsh7th/nvim-cmp") -- Completion
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/vim-vsnip-integ")

	-- snippets
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	-- use("SirVer/ultisnips")
	-- use("mlaursen/vim-react-snippets")

	-- emmet
	use("mattn/emmet-vim")

	-- managing & installing lsp servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use("neovim/nvim-lspconfig") -- configuring lsp servers
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	}) -- LSP UIs
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("jose-elias-alvarez/typescript.nvim") -- renaming, updating .. and so on
	use("folke/lsp-colors.nvim")

	-- formatting & linting //  Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	-- bracket auto-pairs & auto-tag
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- buffer line
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- show hex color
	use("norcalli/nvim-colorizer.lua")

	-- git
	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse
	use("tpope/vim-fugitive")

	-- lazygit
	use("kdheepak/lazygit.nvim")

	-- diffview
	use("sindrets/diffview.nvim")

	-- local git history
	use({
		"jiaoshijie/undotree",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- preview
	use({ "rmagatti/goto-preview" })

	-- toggle terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})

	-- multi cursor
	use("mg979/vim-visual-multi")

	-- live-server // :LiveServer start // :LiveServer stop
	use("barrett-ruth/live-server.nvim")

	-- zen-mode
	use("folke/zen-mode.nvim")

	-- maximizer
	use("szw/vim-maximizer") -- maximizes and restores current window

	-- hop
	use({ "phaazon/hop.nvim", branch = "v2" })

	-- fzf
	use({ "junegunn/fzf", run = "./install --bin" })

	-- codeium
	use({ "Exafunction/codeium.vim" })

	-- color-picker
	use({ "ziontee113/color-picker.nvim" })

	-- harpoon
	use({ "ThePrimeagen/harpoon" })
end)
