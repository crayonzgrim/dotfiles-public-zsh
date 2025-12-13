return {
  "pmizio/typescript-tools.nvim",
  enabled = true,
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      settings = {
        tsserver_plugin = {
          "@styled/typescript-styled-plugin",
        },
        -- Enable inlay hints
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals", -- "none" | "literals" | "all"
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    })

    local autocmd = vim.api.nvim_create_autocmd

    -- Enable inlay hints when LSP attaches
    autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("TypeScriptInlayHints", { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "tsserver" then
          -- Delay to ensure LSP is fully initialized
          vim.defer_fn(function()
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
              print("✓ Inlay hints enabled for tsserver")
            else
              print("⚠ tsserver doesn't support inlay hints")
            end
          end, 100)
        end
      end,
    })

    -- Auto format on save
    autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("TsAutoActions", { clear = true }),
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
      callback = function(args)
        -- pcall로 안전하게
        pcall(vim.cmd, "TSToolsAddMissingImports sync")
        pcall(vim.cmd, "TSToolsOrganizeImports sync")
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
