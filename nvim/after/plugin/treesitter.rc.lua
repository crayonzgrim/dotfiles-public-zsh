local status, tree = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

tree.setup({
	context_commentstring = {
		enable = true,
		config = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
			typescript = { __default = "// %s", __multiline = "/* %s */" },
			css = "// %s",
		},
	},
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"markdown",
		"tsx",
		"toml",
		"fish",
		"python",
		"javascript",
		"typescript",
		"php",
		"json",
		"yaml",
		"swift",
		"css",
		"html",
		"lua",
	},
	autotag = {
		enable = true,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername =
	{ "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" }
