return {
  -- tools
  {
    "williamboman/mason.nvim",
    depends = {
      "williamboman/mason-lspconfig.nvim",
    },
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

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        vtsls = {
          enabled = true,
        },
        tsserver = {
          enabled = false,
          -- root_dir = function(...)
          --   return require("lspconfig.util").root_pattern(".git")(...)
          -- end,
          -- single_file_support = false,
          -- settings = {
          --   typescript = {
          --     inlayHints = {
          --       includeInlayParameterNameHints = "literal",
          --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --       includeInlayFunctionParameterTypeHints = true,
          --       includeInlayVariableTypeHints = false,
          --       includeInlayPropertyDeclarationTypeHints = true,
          --       includeInlayFunctionLikeReturnTypeHints = true,
          --       includeInlayEnumMemberValueHints = true,
          --     },
          --   },
          --   javascript = {
          --     inlayHints = {
          --       includeInlayParameterNameHints = "all",
          --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --       includeInlayFunctionParameterTypeHints = true,
          --       includeInlayVariableTypeHints = true,
          --       includeInlayPropertyDeclarationTypeHints = true,
          --       includeInlayFunctionLikeReturnTypeHints = true,
          --       includeInlayEnumMemberValueHints = true,
          --     },
          --   },
          -- },
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
      local keymap = vim.keymap -- for conciseness

      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "tr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          -- opts.desc = "Go to declaration"
          -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          -- opts.desc = "Show LSP definitions"
          -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          -- opts.desc = "Show LSP implementations"
          -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          -- opts.desc = "Show LSP type definitions"
          -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          -- opts.desc = "See available code actions"
          -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          -- opts.desc = "Go to previous diagnostic"
          -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          -- opts.desc = "Go to next diagnostic"
          -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          -- opts.desc = "Restart LSP"
          -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- if LazyVim.has("neoconf.nvim") then
      --   local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
      --   require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      -- end

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
      local capabilities = vim.lsp.protocol.make_client_capabilities()

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
      -- if have_mason then
      --   all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      -- end

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

  -- {
  -- "neovim/nvim-lspconfig",
  -- event = "LazyFile",
  -- init = function()
  --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
  --   keys[#keys + 1] = {
  --     "gd",
  --     function()
  --       require("telescope.builtin").lsp_definitions({ reuse_win = false })
  --     end,
  --     desc = "Goto Definition",
  --     has = "Definition",
  --   }
  -- end,
  -- dependencies = {
  --   "hrsh7th/cmp-nvim-lsp",
  --   { "antosha417/nvim-lsp-file-operations", config = true },
  --   "mason.nvim",
  --   { "williamboman/mason-lspconfig.nvim", config = function() end },
  -- },
  -- opts = {
  --   inlay_hints = { enabled = false },
  --   ---@type lspconfig.options
  --   servers = {
  --     cssls = {},
  --     tailwindcss = {
  --       root_dir = function(...)
  --         return require("lspconfig.util").root_pattern(".git")(...)
  --       end,
  --     },
  --     tsserver = {
  --       root_dir = function(...)
  --         return require("lspconfig.util").root_pattern(".git")(...)
  --       end,
  --       single_file_support = false,
  --       settings = {
  --         typescript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "literal",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = true,
  --             includeInlayVariableTypeHints = false,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --         },
  --         javascript = {
  --           inlayHints = {
  --             includeInlayParameterNameHints = "all",
  --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --             includeInlayFunctionParameterTypeHints = true,
  --             includeInlayVariableTypeHints = true,
  --             includeInlayPropertyDeclarationTypeHints = true,
  --             includeInlayFunctionLikeReturnTypeHints = true,
  --             includeInlayEnumMemberValueHints = true,
  --           },
  --         },
  --       },
  --     },
  --     ts_ls = { enabled = false },
  --     vtsls = {
  --       enabled = false,
  --       -- -- explicitly add default filetypes, so that we can extend
  --       -- -- them in related extras
  --       -- filetypes = {
  --       --   "javascript",
  --       --   "javascriptreact",
  --       --   "javascript.jsx",
  --       --   "typescript",
  --       --   "typescriptreact",
  --       --   "typescript.tsx",
  --       -- },
  --       -- settings = {
  --       --   complete_function_calls = true,
  --       --   vtsls = {
  --       --     enableMoveToFileCodeAction = true,
  --       --     autoUseWorkspaceTsdk = true,
  --       --     experimental = {
  --       --       maxInlayHintLength = 30,
  --       --       completion = {
  --       --         enableServerSideFuzzyMatch = true,
  --       --       },
  --       --     },
  --       --   },
  --       --   typescript = {
  --       --     updateImportsOnFileMove = { enabled = "always" },
  --       --     suggest = {
  --       --       completeFunctionCalls = true,
  --       --     },
  --       --     inlayHints = {
  --       --       enumMemberValues = { enabled = true },
  --       --       functionLikeReturnTypes = { enabled = true },
  --       --       parameterNames = { enabled = "literals" },
  --       --       parameterTypes = { enabled = true },
  --       --       propertyDeclarationTypes = { enabled = true },
  --       --       variableTypes = { enabled = false },
  --       --     },
  --       --   },
  --       -- },
  --       -- setup = {
  --       --   --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
  --       --   --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
  --       --   tsserver = function()
  --       --     -- disable tsserver
  --       --     return true
  --       --   end,
  --       --   ts_ls = function()
  --       --     -- disable tsserver
  --       --     return true
  --       --   end,
  --       --   vtsls = function(_, opts)
  --       --     local on_attach = function(client, _)
  --       --       client.commands["_typescript.moveToFileRefactoring"] = function(command, _)
  --       --         ---@type string, string, lsp.Range
  --       --         local action, uri, range = unpack(command.arguments)
  --       --
  --       --         local function move(newf)
  --       --           client.request("workspace/executeCommand", {
  --       --             command = command.command,
  --       --             arguments = { action, uri, range, newf },
  --       --           })
  --       --         end
  --       --
  --       --         local fname = vim.uri_to_fname(uri)
  --       --         client.request("workspace/executeCommand", {
  --       --           command = "typescript.tsserverRequest",
  --       --           arguments = {
  --       --             "getMoveToRefactoringFileSuggestions",
  --       --             {
  --       --               file = fname,
  --       --               startLine = range.start.line + 1,
  --       --               startOffset = range.start.character + 1,
  --       --               endLine = range["end"].line + 1,
  --       --               endOffset = range["end"].character + 1,
  --       --             },
  --       --           },
  --       --         }, function(_, result)
  --       --           ---@type string[]
  --       --           local files = result.body.files
  --       --           table.insert(files, 1, "Enter new path...")
  --       --           vim.ui.select(files, {
  --       --             prompt = "Select move destination:",
  --       --             format_item = function(f)
  --       --               return vim.fn.fnamemodify(f, ":~:.")
  --       --             end,
  --       --           }, function(f)
  --       --             if f and f:find("^Enter new path") then
  --       --               vim.ui.input({
  --       --                 prompt = "Enter move destination:",
  --       --                 default = vim.fn.fnamemodify(fname, ":h") .. "/",
  --       --                 completion = "file",
  --       --               }, function(newf)
  --       --                 return newf and move(newf)
  --       --               end)
  --       --             elseif f then
  --       --               move(f)
  --       --             end
  --       --           end)
  --       --         end)
  --       --       end
  --       --     end
  --       --     -- copy typescript settings to javascript
  --       --     opts.settings.javascript =
  --       --       vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
  --       --
  --       --     -- local name = "vtsls"
  --       --     -- vim.api.nvim_create_autocmd("LspAttach", {
  --       --     --   callback = function(args)
  --       --     --     local buffer = args.buf ---@type number
  --       --     --     local client = vim.lsp.get_client_by_id(args.data.client_id)
  --       --     --     if client and (not name or client.name == name) then
  --       --     --       return on_attach(client, buffer)
  --       --     --     end
  --       --     --   end,
  --       --     -- })
  --       --   end,
  --       -- },
  --     },
  --     html = {},
  --     yamlls = {
  --       settings = {
  --         yaml = {
  --           keyOrdering = false,
  --         },
  --       },
  --     },
  --     lua_ls = {
  --       -- enabled = false,
  --       single_file_support = true,
  --       settings = {
  --         Lua = {
  --           workspace = {
  --             checkThirdParty = false,
  --           },
  --           completion = {
  --             workspaceWord = true,
  --             callSnippet = "Both",
  --           },
  --           misc = {
  --             parameters = {
  --               -- "--log-level=trace",
  --             },
  --           },
  --           hint = {
  --             enable = true,
  --             setType = false,
  --             paramType = true,
  --             paramName = "Disable",
  --             semicolon = "Disable",
  --             arrayIndex = "Disable",
  --           },
  --           doc = {
  --             privateName = { "^_" },
  --           },
  --           type = {
  --             castNumberToInteger = true,
  --           },
  --           diagnostics = {
  --             disable = { "incomplete-signature-doc", "trailing-space" },
  --             -- enable = false,
  --             groupSeverity = {
  --               strong = "Warning",
  --               strict = "Warning",
  --             },
  --             groupFileStatus = {
  --               ["ambiguity"] = "Opened",
  --               ["await"] = "Opened",
  --               ["codestyle"] = "None",
  --               ["duplicate"] = "Opened",
  --               ["global"] = "Opened",
  --               ["luadoc"] = "Opened",
  --               ["redefined"] = "Opened",
  --               ["strict"] = "Opened",
  --               ["strong"] = "Opened",
  --               ["type-check"] = "Opened",
  --               ["unbalanced"] = "Opened",
  --               ["unused"] = "Opened",
  --             },
  --             unusedLocalExclude = { "_*" },
  --           },
  --           format = {
  --             enable = false,
  --             defaultConfig = {
  --               indent_style = "space",
  --               indent_size = "2",
  --               continuation_indent_size = "2",
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   setup = {
  --     --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
  --     --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
  --     -- tsserver = function()
  --     --   -- disable tsserver
  --     --   return true
  --     -- end,
  --     ts_ls = function()
  --       -- disable tsserver
  --       return false
  --     end,
  --     vtsls = function(_, opts)
  --       return true
  --       -- LazyVim.lsp.on_attach(function(client, buffer)
  --       --   client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
  --       --     ---@type string, string, lsp.Range
  --       --     local action, uri, range = unpack(command.arguments)
  --       --
  --       --     local function move(newf)
  --       --       client.request("workspace/executeCommand", {
  --       --         command = command.command,
  --       --         arguments = { action, uri, range, newf },
  --       --       })
  --       --     end
  --       --
  --       --     local fname = vim.uri_to_fname(uri)
  --       --     client.request("workspace/executeCommand", {
  --       --       command = "typescript.tsserverRequest",
  --       --       arguments = {
  --       --         "getMoveToRefactoringFileSuggestions",
  --       --         {
  --       --           file = fname,
  --       --           startLine = range.start.line + 1,
  --       --           startOffset = range.start.character + 1,
  --       --           endLine = range["end"].line + 1,
  --       --           endOffset = range["end"].character + 1,
  --       --         },
  --       --       },
  --       --     }, function(_, result)
  --       --       ---@type string[]
  --       --       local files = result.body.files
  --       --       table.insert(files, 1, "Enter new path...")
  --       --       vim.ui.select(files, {
  --       --         prompt = "Select move destination:",
  --       --         format_item = function(f)
  --       --           return vim.fn.fnamemodify(f, ":~:.")
  --       --         end,
  --       --       }, function(f)
  --       --         if f and f:find("^Enter new path") then
  --       --           vim.ui.input({
  --       --             prompt = "Enter move destination:",
  --       --             default = vim.fn.fnamemodify(fname, ":h") .. "/",
  --       --             completion = "file",
  --       --           }, function(newf)
  --       --             return newf and move(newf)
  --       --           end)
  --       --         elseif f then
  --       --           move(f)
  --       --         end
  --       --       end)
  --       --     end)
  --       --   end
  --       -- end, "vtsls")
  --       -- -- copy typescript settings to javascript
  --       -- opts.settings.javascript =
  --       --   vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
  --     end,
  --   },
  -- },
  -- config = function(_, opts)
  --   local keymap = vim.keymap -- for conciseness
  --
  --   local lspconfig = require("lspconfig")
  --
  --   lspconfig["tsserver"].setup({
  --     capabilities = vim.lsp.protocol.make_client_capabilities(),
  --     on_attach = function(client, bufnr)
  --       client.server_capabilities.semanticTokens = nil
  --     end,
  --   })
  --
  --   lspconfig["clangd"].setup({
  --     capabilities = vim.lsp.protocol.make_client_capabilities(),
  --     on_attach = function(client, bufnr)
  --       client.server_capabilities.semanticTokens = nil
  --     end,
  --   })
  --
  --   lspconfig["vtsls"].setup({
  --     capabilities = vim.lsp.protocol.make_client_capabilities(),
  --     on_attach = function(client, bufnr)
  --       client.server_capabilities.semanticTokens = nil
  --     end,
  --   })
  --
  --   vim.api.nvim_create_autocmd("LspAttach", {
  --     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  --     callback = function(ev)
  --       local opts = { buffer = ev.buf, silent = true }
  --       -- set keybinds
  --       opts.desc = "Show LSP references"
  --       keymap.set("n", "rf", "<cmd>Thlescope lsp_references<CR>", opts) -- show definition, references
  --
  --       -- opts.desc = "Go to declaration"
  --       -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
  --
  --       -- opts.desc = "Show LSP definitions"
  --       -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
  --
  --       -- opts.desc = "Show LSP implementations"
  --       -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
  --
  --       -- opts.desc = "Show LSP type definitions"
  --       -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
  --
  --       -- opts.desc = "See available code actions"
  --       -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
  --
  --       opts.desc = "Smart rename"
  --       keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
  --
  --       opts.desc = "Show buffer diagnostics"
  --       keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
  --
  --       opts.desc = "Show line diagnostics"
  --       keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
  --
  --       -- opts.desc = "Go to previous diagnostic"
  --       -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
  --
  --       -- opts.desc = "Go to next diagnostic"
  --       -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
  --
  --       opts.desc = "Show documentation for what is under cursor"
  --       keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
  --
  --       -- opts.desc = "Restart LSP"
  --       -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  --     end,
  --   })
  --
  --   -- setup autoformat
  --   LazyVim.format.register(LazyVim.lsp.formatter())
  --
  --   -- setup keymaps
  --   LazyVim.lsp.on_attach(function(client, buffer)
  --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
  --   end)
  --
  --   local register_capability = vim.lsp.handlers["client/registerCapability"]
  --
  --   vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
  --     ---@diagnostic disable-next-line: no-unknown
  --     local ret = register_capability(err, res, ctx)
  --     local client = vim.lsp.get_client_by_id(ctx.client_id)
  --     local buffer = vim.api.nvim_get_current_buf()
  --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
  --     return ret
  --   end
  --
  --   -- diagnostics signs
  --   if vim.fn.has("nvim-0.10.0") == 0 then
  --     for severity, icon in pairs(opts.diagnostics.signs.text) do
  --       local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
  --       name = "DiagnosticSign" .. name
  --       vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  --     end
  --   end
  --
  --   -- inlay hints
  --   if opts.inlay_hints.enabled then
  --     LazyVim.lsp.on_attach(function(client, buffer)
  --       if client.supports_method("textDocument/inlayHint") then
  --         Snacks.toggle.inlay_hints(buffer, true)
  --       end
  --     end)
  --   end
  --
  --   if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
  --     opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
  --       or function(diagnostic)
  --         local icons = require("lazyvim.config").icons.diagnostics
  --         for d, icon in pairs(icons) do
  --           if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
  --             return icon
  --           end
  --         end
  --       end
  --   end
  --
  --   vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
  --
  --   local servers = opts.servers
  --   local capabilities = vim.lsp.protocol.make_client_capabilities()
  --
  --   local function setup(server)
  --     local server_opts = vim.tbl_deep_extend("force", {
  --       capabilities = vim.deepcopy(capabilities),
  --     }, servers[server] or {})
  --
  --     if opts.setup[server] then
  --       if opts.setup[server](server, server_opts) then
  --         return
  --       end
  --     elseif opts.setup["*"] then
  --       if opts.setup["*"](server, server_opts) then
  --         return
  --       end
  --     end
  --     require("lspconfig")[server].setup(server_opts)
  --   end
  --
  --   -- get all the servers that are available through mason-lspconfig
  --   local have_mason, mlsp = pcall(require, "mason-lspconfig")
  --   local all_mslp_servers = {}
  --   -- if have_mason then
  --   --   all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  --   -- end
  --
  --   local ensure_installed = {} ---@type string[]
  --   for server, server_opts in pairs(servers) do
  --     if server_opts then
  --       server_opts = server_opts == true and {} or server_opts
  --       -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
  --       if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
  --         setup(server)
  --       elseif server_opts.enabled ~= false then
  --         ensure_installed[#ensure_installed + 1] = server
  --       end
  --     end
  --   end
  --
  --   if have_mason then
  --     mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
  --   end
  --
  --   if LazyVim.lsp.get_config("denols") and LazyVim.lsp.get_config("tsserver") then
  --     local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
  --     LazyVim.lsp.disable("tsserver", is_deno)
  --     LazyVim.lsp.disable("denols", function(root_dir)
  --       return not is_deno(root_dir)
  --     end)
  --   end
  -- end,
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            -- DO NOT RESUSE WINDOW
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
      })
    end,
  },

  {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  },
}
