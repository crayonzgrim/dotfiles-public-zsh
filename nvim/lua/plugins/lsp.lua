return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gd",
        function()
          -- DO NOT RESUSE WINDOW
          require("telescope.builtin").lsp_definitions({ reuse_win = false })
        end,
        desc = "Goto Definition",
        has = "definition",
      }
    end,
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
    config = function(_, opts)
      if LazyVim.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end

      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        ---@diagnostic disable-next-line: no-unknown
        local ret = register_capability(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
          name = "DiagnosticSign" .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end

      -- inlay hints
      if opts.inlay_hints.enabled then
        LazyVim.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            LazyVim.toggle.inlay_hints(buffer, true)
          end
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        LazyVim.lsp.on_attach(function(client, buffer)
          if client.supports_method("textDocument/codeLens") then
            vim.lsp.codelens.refresh()
            --- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("lazyvim.config").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          elseif server_opts.enabled ~= false then
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if LazyVim.lsp.get_config("denols") and LazyVim.lsp.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        LazyVim.lsp.disable("tsserver", is_deno)
        LazyVim.lsp.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
  -- lsp servers
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     { "antosha417/nvim-lsp-file-operations", config = true },
  --   },
  --   init = function()
  --     local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --     keys[#keys + 1] = {
  --       "gd",
  --       function()
  --         -- DO NOT RESUSE WINDOW
  --         require("telescope.builtin").lsp_definitions({ reuse_win = false })
  --       end,
  --       desc = "Goto Definition",
  --       has = "definition",
  --     }
  --   end,
  --   config = function()
  --     -- import lspconfig plugin
  --     local lspconfig = require("lspconfig")
  --
  --     -- import cmp-nvim-lsp plugin
  --     local cmp_nvim_lsp = require("cmp_nvim_lsp")
  --
  --     local keymap = vim.keymap -- for conciseness
  --     local options = {
  --       noremap = true,
  --       silent = true,
  --     }
  --     local on_attach = function(client, bufnr)
  --       options.buffer = bufnr
  --
  --       -- set keybinds
  --       options.desc = "Show LSP references"
  --       keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", options) -- show definition, references
  --
  --       options.desc = "Go to declaration"
  --       keymap.set("n", "gD", vim.lsp.buf.declaration, options) -- go to declaration
  --
  --       -- options.desc = "Show LSP definitions"
  --       -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", options) -- show lsp definitions
  --
  --       options.desc = "Show LSP implementations"
  --       keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", options) -- show lsp implementations
  --
  --       options.desc = "Show LSP type definitions"
  --       keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", options) -- show lsp type definitions
  --
  --       options.desc = "See available code actions"
  --       keymap.set({ "n", "v" }, "<C-a>", vim.lsp.buf.code_action, options) -- see available code actions, in visual mode will apply to selection
  --
  --       options.desc = "Smart rename"
  --       keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options) -- smart rename
  --
  --       options.desc = "Show current buffer diagnostics"
  --       keymap.set("n", "\\e", "<cmd>Telescope diagnostics bufnr=0<CR>", options) -- show  diagnostics for file
  --
  --       options.desc = "Show line diagnostics"
  --       keymap.set("n", "<leader>d", vim.diagnostic.open_float, options) -- show diagnostics for line
  --
  --       options.desc = "Go to previous diagnostic"
  --       keymap.set("n", "[d", vim.diagnostic.goto_prev, options) -- jump to previous diagnostic in buffer
  --
  --       options.desc = "Go to next diagnostic"
  --       keymap.set("n", "]d", vim.diagnostic.goto_next, options) -- jump to next diagnostic in buffer
  --
  --       options.desc = "Show documentation for what is under cursor"
  --       keymap.set("n", "K", vim.lsp.buf.hover, options) -- show documentation for what is under cursor
  --
  --       options.desc = "Signature help"
  --       keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, options) -- mapping to restart lsp if necessary
  --     end
  --
  --     -- used to enable autocompletion (assign to every lsp server config)
  --     local capabilities = cmp_nvim_lsp.default_capabilities()
  --
  --     -- Change the Diagnostic symbols in the sign column (gutter)
  --     -- (not in youtube nvim video)
  --     local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  --     for type, icon in pairs(signs) do
  --       local hl = "DiagnosticSign" .. type
  --       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  --     end
  --
  --     -- configure html server
  --     lspconfig["html"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure typescript server with plugin
  --     lspconfig["tsserver"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure css server
  --     lspconfig["cssls"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure tailwindcss server
  --     lspconfig["tailwindcss"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure svelte server
  --     lspconfig["svelte"].setup({
  --       capabilities = capabilities,
  --       on_attach = function(client, bufnr)
  --         on_attach(client, bufnr)
  --
  --         vim.api.nvim_create_autocmd("BufWritePost", {
  --           pattern = { "*.js", "*.ts" },
  --           callback = function(ctx)
  --             if client.name == "svelte" then
  --               client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
  --             end
  --           end,
  --         })
  --       end,
  --     })
  --
  --     lspconfig["astro"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure prisma orm server
  --     lspconfig["prismals"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure graphql language server
  --     lspconfig["graphql"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact", "astro" },
  --     })
  --
  --     -- configure emmet language server
  --     lspconfig["emmet_ls"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       filetypes = {
  --         "astro",
  --         "css",
  --         "eruby",
  --         "html",
  --         "javascript",
  --         "javascriptreact",
  --         "less",
  --         "sass",
  --         "scss",
  --         "svelte",
  --         "pug",
  --         "typescriptreact",
  --         "vue",
  --       },
  --     })
  --
  --     -- configure python server
  --     lspconfig["pyright"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     lspconfig["dartls"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --     })
  --
  --     -- configure lua server (with special settings)
  --     lspconfig["lua_ls"].setup({
  --       capabilities = capabilities,
  --       on_attach = on_attach,
  --       settings = { -- custom settings for lua
  --         Lua = {
  --           -- make the language server recognize "vim" global
  --           diagnostics = {
  --             globals = { "vim" },
  --           },
  --           workspace = {
  --             -- make language server aware of runtime files
  --             library = {
  --               [vim.fn.expand("$VIMRUNTIME/lua")] = true,
  --               [vim.fn.stdpath("config") .. "/lua"] = true,
  --             },
  --           },
  --           -- Do not send telemetry data containing a randomized but unique identifier
  --           telemetry = {
  --             enable = false,
  --           },
  --           hint = {
  --             enable = true,
  --           },
  --         },
  --       },
  --     })
  --   end,
  --
  --   opts = {
  --     inlay_hints = { enabled = true },
  --     servers = {
  --       astro = {},
  --       cssls = {},
  --       tailwindcss = {
  --         root_dir = function(...)
  --           return require("lspconfig.util").root_pattern(".git")(...)
  --         end,
  --       },
  --       tsserver = {
  --         root_dir = function(...)
  --           return require("lspconfig.util").root_pattern(".git")(...)
  --         end,
  --         single_file_support = false,
  --         settings = {
  --           javascript = {
  --             inlayHints = {
  --               includeInlayParameterNameHints = "all",
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayEnumMemberValueHints = true,
  --             },
  --           },
  --           typescript = {
  --             inlayHints = {
  --               includeInlayParameterNameHints = "literal",
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayEnumMemberValueHints = true,
  --             },
  --           },
  --         },
  --       },
  --       html = {},
  --       yamlls = {
  --         settings = {
  --           yaml = {
  --             keyOrdering = false,
  --           },
  --         },
  --       },
  --       lua_ls = {
  --         enabled = true,
  --         single_file_support = true,
  --         settings = {
  --           Lua = {
  --             workspace = {
  --               checkThirdParty = false,
  --             },
  --             completion = {
  --               workspaceWord = true,
  --               callSnippet = "Both",
  --             },
  --             misc = {
  --               parameters = {
  --                 -- "--log-level=trace",
  --               },
  --             },
  --             hint = {
  --               enable = true,
  --             },
  --             doc = {
  --               privateName = { "^_" },
  --             },
  --             type = {
  --               castNumberToInteger = true,
  --             },
  --             diagnostics = {
  --               disable = { "incomplete-signature-doc", "trailing-space" },
  --               -- enable = false,
  --               groupSeverity = {
  --                 strong = "Warning",
  --                 strict = "Warning",
  --               },
  --               groupFileStatus = {
  --                 ["ambiguity"] = "Opened",
  --                 ["await"] = "Opened",
  --                 ["codestyle"] = "None",
  --                 ["duplicate"] = "Opened",
  --                 ["global"] = "Opened",
  --                 ["luadoc"] = "Opened",
  --                 ["redefined"] = "Opened",
  --                 ["strict"] = "Opened",
  --                 ["strong"] = "Opened",
  --                 ["type-check"] = "Opened",
  --                 ["unbalanced"] = "Opened",
  --                 ["unused"] = "Opened",
  --               },
  --               unusedLocalExclude = { "_*" },
  --             },
  --             format = {
  --               enable = false,
  --               defaultConfig = {
  --                 indent_style = "space",
  --                 indent_size = "2",
  --                 continuation_indent_size = "2",
  --               },
  --             },
  --           },
  --         },
  --       },
  --     },
  --     setup = {},
  --   },
  -- },
}
