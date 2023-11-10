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

local action_state = require("telescope.actions.state")

--- Insert filename into the current buffer and keeping the insert mode.
actions.insert_name_i = function(prompt_bufnr)
	local symbol = action_state.get_selected_entry().ordinal
	actions.close(prompt_bufnr)
	vim.schedule(function()
		vim.cmd([[startinsert]])
		vim.api.nvim_put({ symbol }, "", true, true)
	end)
end

--- Insert file path and name into the current buffer and keeping the insert mode.
actions.insert_name_and_path_i = function(prompt_bufnr)
	local symbol = action_state.get_selected_entry().value
	actions.close(prompt_bufnr)
	vim.schedule(function()
		vim.cmd([[startinsert]])
		vim.api.nvim_put({ symbol }, "", true, true)
	end)
end

telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		file_ignore_patterns = { "node_modules" },
		path_display = { "smart" },
		mappings = {
			n = {
				["q"] = actions.close,
			},
			i = {
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
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
				["i"] = {
					["<C-j>"] = actions.cycle_history_next,
					["<C-k>"] = actions.cycle_history_prev,

					["<C-m>"] = fb_actions.move,
					["<C-y>"] = actions.insert_name_i,
					["<C-p>"] = actions.insert_name_and_path_i,
				},
				["n"] = {
					["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
					["<C-u>"] = function(prompt_bufnr)
						for i = 1, 10 do
							actions.move_selection_previous(prompt_bufnr)
						end
					end,
					["<C-d>"] = function(prompt_bufnr)
						for i = 1, 10 do
							actions.move_selection_next(prompt_bufnr)
						end
					end,
					["<PageUp>"] = actions.preview_scrolling_up,
					["<PageDown>"] = actions.preview_scrolling_down,
				},
			},
		},
	},
})

telescope.load_extension("lazygit")
telescope.load_extension("file_browser")
telescope.load_extension("media_files")
telescope.load_extension("fzf")
telescope.load_extension("harpoon")

vim.keymap.set("n", ";m", function()
	telescope.extensions.media_files.media_files()
end)

vim.keymap.set("n", ";f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.live_grep({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";fb", function()
	builtin.buffers()
end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)
vim.keymap.set("n", ";gs", function()
	builtin.git_status()
end)
vim.keymap.set("n", ";gb", function()
	builtin.git_branches()
end)
vim.keymap.set("n", ";gc", function()
	builtin.git_commits()
end)
vim.keymap.set("n", ";gs", function()
	builtin.git_stash()
end)
vim.keymap.set("n", "sf", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		grouped = true,
		previewer = true,
		initial_mode = "normal",
		layout_config = { height = 23 },
	})
end)
vim.keymap.set("n", "fw", function()
	builtin.grep_string()
end)
vim.keymap.set("n", "fh", ":Telescope harpoon marks<CR>", { silent = true })
vim.keymap.set("n", "fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
