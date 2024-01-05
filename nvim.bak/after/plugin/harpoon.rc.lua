local status1, mark = pcall(require, "harpoon.mark")
if not status1 then
	return
end

local status2, ui = pcall(require, "harpoon.ui")
if not status2 then
	return
end

require("harpoon").setup({
	global_settings = {
		save_on_toggle = false,
		save_on_change = true,
		enter_on_sendcmd = false,
		tmux_autoclose_windows = false,
		excluded_filetypes = { "harpoon" },
		mark_branch = true,
		tabline = false,
		tabline_prefix = " ",
		tabline_suffix = " ",
	},
	menu = {
		width = vim.api.nvim_win_get_width(0) - 100,
	},
})

local keymap = vim.keymap.set

keymap("n", "\\a", mark.add_file)
keymap("n", "\\o", ui.toggle_quick_menu)

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
