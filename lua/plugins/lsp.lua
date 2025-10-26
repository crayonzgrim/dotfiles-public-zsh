return {
  -- tools
  {
    "mason-org/mason.nvim",
    depends = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = function(_, opts)
      -- Remove stylua from LazyVim's default ensure_installed
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "stylua"
      end, opts.ensure_installed or {})

      vim.list_extend(opts.ensure_installed, {
        -- "stylua", -- Removed: not an LSP server, handled by conform.nvim
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
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        -- stylua = { enabled = false },
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
      setup = {
        -- Skip stylua setup completely (it's not an LSP server, only a formatter)
        stylua = function()
          return true
        end,
      },
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

          opts.desc = "Goto Definition (no reuse window)"
          keymap.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end, opts) -- show lsp definitions without reusing window

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

      -- setup keymaps using Snacks instead of LazyVim.lsp.on_attach
      if vim.fn.exists(":Snacks") == 2 then
        Snacks.util.lsp.on(function(client, buffer)
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
        -- Skip wildcard server configurations (used for keys, not actual servers)
        if server ~= "*" and server_opts then
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

      if LazyVim.lsp and LazyVim.lsp.get_config then
        if LazyVim.lsp.get_config("denols") and LazyVim.lsp.get_config("tsserver") then
          local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
          LazyVim.lsp.disable("tsserver", is_deno)
          LazyVim.lsp.disable("denols", function(root_dir)
            return not is_deno(root_dir)
          end)
        end
      end
    end,
  },

  {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  },
}
