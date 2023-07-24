local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
	return
end

local config_status, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- recommended settings from nvim-tree documentation
-- vim.g.loaded = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrw_plugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	hijack_netrw = true,
	hijack_cursor = true,
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = false,
		highlight_opened_files = "1",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			-- hint = "💡",
			hint = " ",
			info = "ℹ️",
			warning = "⚠️",
			error = "🐞",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	git = {
		enable = false,
		-- ignore = false,
		timeout = 500,
	},
	actions = {
		open_file = {
			resize_window = true,
			window_picker = {
				enable = false,
			},
		},
	},
	view = {
		side = "left",
		width = 40,
		hide_root_folder = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "v", cb = tree_cb("vsplit") },
				{ key = "s", cb = tree_cb("split") },
			},
		},
		number = false,
		relativenumber = false,
	},
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
