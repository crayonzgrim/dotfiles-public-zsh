local status, tree = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

local queries = require("nvim-treesitter.query")

tree.setup({
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	-- context_commentstring = {
	-- 	enable = true,
	-- 	enable_autocmd = false,
	-- 	config = {
	-- 		javascript = {
	-- 			__default = "// %s",
	-- 			jsx_element = "{/* %s */}",
	-- 			jsx_fragment = "{/* %s */}",
	-- 			jsx_attribute = "// %s",
	-- 			comment = "// %s",
	-- 		},
	-- 		typescript = { __default = "// %s", __multiline = "/* %s */" },
	-- 		css = "// %s",
	-- 	},
	-- },
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
		"markdown_inline",
		"json",
		"toml",
		"fish",
		"python",
		"javascript",
		"typescript",
		"tsx",
		"php",
		"yaml",
		"swift",
		"css",
		"html",
		"lua",
		"svelte",
		"graphql",
		"bash",
		"vim",
		"dockerfile",
		"gitignore",
	},
	autotag = {
		enable = true,
	},
	rainbow = {
		enable = true,
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- module_path = "rainbow.internal",
		is_supported = function(lang)
			return queries.get_query(lang, "parens") ~= nil
		end,
		extended_mode = true,
		colors = {
			"#cc241d",
			"#a89984",
			"#b16286",
			"#d79921",
			"#689d6a",
			"#d65d0e",
			"#458588",
		},
		termcolors = {
			"Red",
			"Green",
			"Yellow",
			"Blue",
			"Magenta",
			"Cyan",
			"White",
		},
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername =
	{ "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" }
