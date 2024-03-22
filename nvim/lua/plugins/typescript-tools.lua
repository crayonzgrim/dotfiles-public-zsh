return {
  "pmizio/typescript-tools.nvim",
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function()
    local api = require("typescript-tools.api")

    require("typescript-tools").setup({
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
      },
      settings = {
        separate_diagnostic_server = true,
        expose_as_code_action = "all",
        -- tsserver_plugins = {},
        tsserver_max_memory = "auto",
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
          -- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
        },
        tsserver_format_options = {
          TSToolsRemoveUnusedImports = false,
        },
      },
    })
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWritePre", {
      pattern = "*.ts,*.tsx,*.jsx,*.js",
      callback = function(args)
        vim.cmd("TSToolsAddMissingImports sync")
        vim.cmd("TSToolsOrganizeImports sync")
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
