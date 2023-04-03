local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.load_extension("lazygit")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

-- --- Insert filename into the current buffer and keeping the insert mode.
-- actions.insert_name_i = function(prompt_bufnr)
-- 	local symbol = action_state.get_selected_entry().ordinal
-- 	actions.close(prompt_bufnr)
-- 	vim.schedule(function()
-- 		vim.cmd([[startinsert]])
-- 		vim.api.nvim_put({ symbol }, "", true, true)
-- 	end)
-- end
--
-- --- Insert file path and name into the current buffer and keeping the insert mode.
-- actions.insert_name_and_path_i = function(prompt_bufnr)
-- 	local symbol = action_state.get_selected_entry().value
-- 	actions.close(prompt_bufnr)
-- 	vim.schedule(function()
-- 		vim.cmd([[startinsert]])
-- 		vim.api.nvim_put({ symbol }, "", true, true)
-- 	end)
-- end

telescope.setup({
	defaults = {
		path_display = { "smart" },
		-- sorting_strategy = "descending",
		-- winblend = 10,
		mappings = {
			n = {
				["q"] = actions.close,
			},
			i = {
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
				["q"] = actions.close,
				-- ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				-- ["<C-y>"] = actions.insert_name_i,
				-- ["<C-p>"] = actions.insert_name_and_path_i,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown", -- "ivy" -- "dropdown"
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					-- ["<S-m>"] = fb_actions.move,
					-- ["<C-y>"] = actions.insert_name_i,
					-- ["<C-p>"] = actions.insert_name_and_path_i,
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

telescope.load_extension("file_browser")

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
vim.keymap.set("n", ";t", function()
	builtin.help_tags()
end)
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
