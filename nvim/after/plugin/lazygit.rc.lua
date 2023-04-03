local status, lazy = pcall(require, "lazygit")
if not status then
	return
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>lg", "<Cmd>LazyGit<CR>", opts)
