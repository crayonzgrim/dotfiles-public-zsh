local status, undotree = pcall(require, "undotree")
if not status then
	return
end

undotree.setup({
	float_diff = true, -- using float window previews diff, set this `true` will disable layout option
	layout = "left_bottom", -- "left_bottom", "left_left_bottom"
	ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
	window = {
		winblend = 5,
	},
	keymaps = {
		["j"] = "move_next",
		["k"] = "move_prev",
		["J"] = "move_change_next",
		["K"] = "move_change_prev",
		["<cr>"] = "action_enter",
		["p"] = "enter_diffbuf",
		["q"] = "quit",
	},
})

vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
--
-- Enable undofile and specify undodir
local config_dir = vim.fn.stdpath("config")

vim.opt.undofile = true
vim.opt.undodir = config_dir .. "/undodir"
vim.opt.undolevels = 100
