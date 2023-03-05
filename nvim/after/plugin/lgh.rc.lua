local status, history = pcall(require, "lgh")
if not status then
	return
end

history.setup({
	basedir = vim.fn.stdpath("data") .. "/githistory/",
	git_cmd = "git",
	verbose = false,
	fix_ownership = true,
	diff = true,
	new_window = "vnew",
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>u", "<Cmd>LGHistory<CR>", opts)
