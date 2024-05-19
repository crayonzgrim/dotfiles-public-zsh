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
        },
        tsserver_format_options = {
          TSToolsOrganizeImports = true, -- sorts and removes unused imports
          TSToolsRemoveUnusedImports = true, --  removes unused imports
          TSToolsRemoveUnused = true, --  removes all unused statements
          TSToolsSortImports = true, --  sorts imports
          TSToolsAddMissingImports = true, -- adds imports for all statements that lack one and can be imported
          TSToolsFixAll = true, -- fixes all fixable errors
          TSToolsGoToSourceDefinition = true, -- goes to source definition (available since TS v4.7)
          TSToolsRenameFile = true, -- allow to rename current file and apply changes to connected files
          TSToolsFileReferences = true, -- find files that reference the current file (available since TS v4.2)
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
