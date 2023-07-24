local status1, mark = pcall(require, "harpoon.mark")
if not status1 then
	return
end

local status2, ui = pcall(require, "harpoon.ui")
if not status2 then
	return
end

require("harpoon").setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 100,
	},
})

local keymap = vim.keymap.set

keymap("n", "<leader>a", mark.add_file)
keymap("n", "<leader>o", ui.toggle_quick_menu)

keymap("n", "<leader>1", function()
	ui.nav_file(1)
end)
keymap("n", "<leader>2", function()
	ui.nav_file(2)
end)
keymap("n", "<leader>3", function()
	ui.nav_file(3)
end)
keymap("n", "<leader>4", function()
	ui.nav_file(4)
end)

keymap("n", "<leader>[", ui.nav_next)
keymap("n", "<leader>]", ui.nav_prev)
