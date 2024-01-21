return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>fo", "<cmd>Telescope flutter commands<cr>", { noremap = true })

      -- local custom_config = require("custom.plugins.lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local custom_config = cmp_nvim_lsp.default_capabilities()

      -- alternatively you can override the default configs
      require("flutter-tools").setup({
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = true,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = true,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = false,
          },
        },
        widget_guides = {
          enabled = true,
        },
        dev_log = {
          enabled = true,
          open_cmd = "10sp", -- command to use to open the log buffer
        },
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = true, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },
          -- on_attach = custom_config.on_attach,
          -- capabilities = custom_config.capabilities,
          -- flags = custom_config.flags,
          -- handlers = custom_config.handlers,
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt", -- "always"
            enableSnippets = true,
          },
        },
      })
    end,
  },
}
