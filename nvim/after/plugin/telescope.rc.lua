local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local fb_actions = require("telescope").extensions.file_browser.actions

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules" },
		path_display = { "smart" },
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		media_files = {
			-- filetypes whitelist
			filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4", "svg" },
			-- find command (defaults to `fd`)
			find_cmd = "rg",
		},
		file_browser = {
			theme = "dropdown", -- "ivy" -- "dropdown"
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
	},
})

telescope.load_extension("lazygit")
telescope.load_extension("file_browser")
telescope.load_extension("media_files")

vim.keymap.set("n", ";w", function()
	telescope.extensions.media_files.media_files()
end)

vim.keymap.set("n", ";f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.live_grep()
end)
vim.keymap.set("n", "\\\\", function()
	builtin.buffers()
end)
-- vim.keymap.set("n", ";t", function()
-- 	builtin.help_tags()
-- end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)
vim.keymap.set("n", ";s", function()
	builtin.git_status()
end)
vim.keymap.set("n", ";c", function()
	builtin.git_commits()
end)
vim.keymap.set("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)
