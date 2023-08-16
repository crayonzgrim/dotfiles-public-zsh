local Hydra = require("hydra")

Hydra({
	name = "Change / Resize Window",
	mode = { "n" },
	body = "<C-w>",
	config = {
		-- color = "pink",
	},
	heads = {
		-- resizing window
		{ "H", "<C-w>3<" },
		{ "L", "<C-w>3>" },
		{ "K", "<C-w>2+" },
		{ "J", "<C-w>2-" },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})
