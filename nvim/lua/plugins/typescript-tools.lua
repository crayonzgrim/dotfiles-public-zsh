return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    require("typescript-tools").setup({
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 6133 }),
      },
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          importModuleSpecifierPreference = "non-relative",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        tsserver_format_options = {
          TSToolsRemoveUnusedImports = true,
          TSToolsRemoveUnused = true,
          TSToolsOrganizeImports = true,
          TSToolsRenameFile = true,
        },
        tsserver_plugin = {
          "@styled/typescript-styled-plugin",
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
