local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		mode = "tabs", -- tabs -- buffers
		separator_style = "slant", -- slant -- slop -- padded_slant
		always_show_bufferline = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
		diagnostics = "nvim_lsp", -- | false | "nvim_lsp" | "coc",
	},
	highlights = {
		separator = {
			fg = "#073642",
			bg = "#002b36",
		},
		separator_selected = {
			fg = "#073642",
		},
		background = {
			-- fg = "#657b83",
			bg = "#002b36",
		},
		buffer_selected = {
			fg = "#fdf6e3",
			bold = true,
		},
		fill = {
			-- bg = "#073642",
		},
	},
})

vim.keymap.set("n", "}", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "{", "<Cmd>BufferLineCyclePrev<CR>", {})
