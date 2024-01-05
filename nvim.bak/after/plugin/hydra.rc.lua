local status, Hydra = pcall(require, "hydra")
if not status then
	return
end
local cmd = require("hydra.keymap-util").cmd

Hydra({
	name = "Resize Window",
	mode = { "n" },
	body = "<C-w>",
	config = {
		-- color = "pink",
	},
	heads = {
		-- resizing window
		{ "H", "<C-w>2<" },
		{ "L", "<C-w>2>" },
		{ "K", "<C-w>2+" },
		{ "J", "<C-w>2-" },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

Hydra({
	name = "Side scroll",
	mode = "n",
	body = "z",
	heads = {
		{ "h", "5zh" },
		{ "l", "5zl", { desc = "←/→" } },
		{ "H", "zH" },
		{ "L", "zL", { desc = "half screen ←/→" } },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

local telescopeHint = [[
 _f_: files       _m_: marks
 _o_: old files   _g_: live grep
 _p_: projects    _/_: search in file

 _r_: resume      _u_: undotree
 _h_: vim help    _c_: execute command
 _k_: keymaps     _;_: commands history
 _O_: options     _?_: search history
]]

Hydra({
	name = "Telescope",
	hint = telescopeHint,
	config = {
		color = "teal",
		invoke_on_body = true,
		hint = {
			position = "middle",
			border = "rounded",
		},
	},
	mode = "n",
	body = "\\f",
	heads = {
		{ "f", cmd("Telescope find_files") },
		{ "g", cmd("Telescope live_grep") },
		{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
		{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
		{ "m", cmd("MarksListBuf"), { desc = "marks" } },
		{ "k", cmd("Telescope keymaps") },
		{ "O", cmd("Telescope vim_options") },
		{ "r", cmd("Telescope resume") },
		{ "p", cmd("Telescope projects"), { desc = "projects" } },
		{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
		{ "?", cmd("Telescope search_history"), { desc = "search history" } },
		{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
		{ "c", cmd("Telescope commands"), { desc = "execute command" } },
		{ "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
		-- { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})
