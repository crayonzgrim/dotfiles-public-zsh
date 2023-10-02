local status, indent = pcall(require, "ibl")
if not status then
	return
end

indent.setup({
	indent = { char = "│", tab_char = "│" },
	scope = {
		show_start = false,
		show_end = true,
		injected_languages = true,
		priority = 1024,
		include = {
			node_type = {
				["*"] = {
					"arguments",
					"block",
					"bracket",
					"declaration",
					"expression_list",
					"field",
					"for",
					"func_literal",
					"function",
					"if",
					"import",
					"list",
					"return_statement",
					"short_var_declaration",
					"switch_body",
					"try",
					"type",
				},
			},
		},
	},
})
