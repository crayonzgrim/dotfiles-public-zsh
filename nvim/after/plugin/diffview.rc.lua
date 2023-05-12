local status, diffview = pcall(require, "diffview")
if not status then
	return
end

diffview.setup({})

vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { silent = true })
vim.keymap.set("n", "<leader>dmo", "<cmd>DiffviewOpen master<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>DiffviewClose<cr>", { silent = true })
