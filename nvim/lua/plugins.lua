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
	-- use({ "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" })
	use({
		"svrana/neosolarized.nvim",
		requires = { "tjdevries/colorbuddy.nvim" },
	})
	-- use({
	-- 	"catppuccin/nvim",
	-- 	as = "catppuccin",
	-- })

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
			require("nvim-treesitter.install").update({
				with_sync = true,
			})
		end,
	})

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- telescope file find
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")

	-- auto completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	-- managing & installing lsp servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	}) -- LSP UIs
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("jose-elias-alvarez/typescript.nvim") -- renaming, updating .. and so on

	-- formatting & linting //  Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	-- bracket auto-pairs & auto-tag
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- buffer line
	use("akinsho/nvim-bufferline.lua")

	-- show hex color
	use("norcalli/nvim-colorizer.lua")

	-- git
	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse

	-- markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- toggle terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})
	-- use("voldikss/vim-floaterm")

	-- cmp-tabnine
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	})
end)
