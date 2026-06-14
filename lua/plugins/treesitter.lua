return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "astro",
        "cmake",
        "cpp",
        "css",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "http",
        "java",
        "php",
        "rust",
        "scss",
        "sql",
        "svelte",
      },

      -- matchup = {
      -- 	enable = true,
      -- },

      -- https://github.com/nvim-treesitter/playground#query-linter
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      TS.setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "main",
  --   version = false,
  --   build = function()
  --     local TS = require("nvim-treesitter")
  --     if not TS.get_installed then
  --       LazyVim.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
  --       return
  --     end
  --     LazyVim.treesitter.ensure_treesitter_cli(function()
  --       TS.update(nil, { summary = true })
  --     end)
  --   end,
  --   lazy = vim.fn.argc(-1) == 0,
  --   event = { "LazyFile", "VeryLazy" },
  --   cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  --   opts_extend = { "ensure_installed" },
  --   opts = {
  --     indent = { enable = true },
  --     highlight = { enable = true },
  --     folds = { enable = true },
  --     ensure_installed = {
  --       "astro",
  --       "cmake",
  --       "cpp",
  --       "css",
  --       "fish",
  --       "gitignore",
  --       "go",
  --       "graphql",
  --       "http",
  --       "java",
  --       "php",
  --       "rust",
  --       "scss",
  --       "sql",
  --       "svelte",
  --     },
  --   },
  --   config = function(_, opts)
  --     local TS = require("nvim-treesitter")
  --
  --     if not TS.get_installed then
  --       return LazyVim.error("Please use `:Lazy` and update `nvim-treesitter`")
  --     elseif type(opts.ensure_installed) ~= "table" then
  --       return LazyVim.error("`nvim-treesitter` opts.ensure_installed must be a table")
  --     end
  --
  --     TS.setup(opts)
  --     LazyVim.treesitter.get_installed(true)
  --
  --     local install = vim.tbl_filter(function(lang)
  --       return not LazyVim.treesitter.have(lang)
  --     end, opts.ensure_installed or {})
  --     if #install > 0 then
  --       LazyVim.treesitter.ensure_treesitter_cli(function()
  --         TS.install(install, { summary = true }):await(function()
  --           LazyVim.treesitter.get_installed(true)
  --         end)
  --       end)
  --     end
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
  --       callback = function(ev)
  --         if not LazyVim.treesitter.have(ev.match) then
  --           return
  --         end
  --
  --         if vim.tbl_get(opts, "highlight", "enable") ~= false then
  --           pcall(vim.treesitter.start)
  --         end
  --
  --         if vim.tbl_get(opts, "indent", "enable") ~= false then
  --           vim.bo[ev.buf].indentexpr = "v:lua.LazyVim.treesitter.indentexpr()"
  --         end
  --
  --         if vim.tbl_get(opts, "folds", "enable") ~= false then
  --           vim.wo.foldmethod = "expr"
  --           vim.wo.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
