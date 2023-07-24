local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({
	ui = {
		title = true,
		border = "rounded",
		winblend = 10,
		colors = {
			normal_bg = "#002b36",
		},
	},
	symbol_in_winbar = {
		enable = false,
	},
})

local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_diagnostic<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("i", "<leader>h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", opts)
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)

-- code action
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>Lspsaga code_action<CR>")
