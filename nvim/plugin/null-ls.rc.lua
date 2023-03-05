local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

null_ls.setup({
	sources = {
		formatting.prettierd,
		formatting.stylua,
		diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
		}),
		null_ls.builtins.diagnostics.fish,
		require("typescript.extensions.null-ls.code-actions"),
	},
	-- configure format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
