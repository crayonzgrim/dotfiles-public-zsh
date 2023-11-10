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
vim.g.loaded_netrw = 1
vim.g.loaded_netrw_plugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
	sort_by = "case_sensitive",
	hijack_directories = {
		enable = false,
		auto_open = false,
	},
	update_focused_file = {
		enable = false,
		update_cwd = true,
	},
	log = {
		enable = true,
		types = {
			diagnostics = true,
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		debounce_delay = 50,
		icons = {
			hint = "💡",
			info = "ℹ️",
			warning = "⚠️",
			error = "🐞",
		},
	},
	view = {
		adaptive_size = false,
		hide_root_folder = false,
		width = 40,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
				{ key = "s", cb = tree_cb("split") },
				{ key = "u", cb = tree_cb("dir_up") },
				{ key = "e", cb = tree_cb("toggle") },
				{ key = "i", cb = tree_cb("show_info_popup") },
			},
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = true,
		full_name = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = false,
			-- inline_arrow = true,
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
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "✗",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	filters = {
		custom = { ".DS_Store", "^.git$", "^.github$" },
	},
	git = {
		enable = true,
		timeout = 500,
	},
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
