local status, zenMode = pcall(require, "zen-mode")
if not status then
	return
end

zenMode.setup({})

vim.keymap.set("n", "<C-z>o", "<cmd>ZenMode<cr>", { silent = true })
