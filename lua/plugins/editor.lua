return {
  {
    "folke/flash.nvim",
    enabled = false,
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "background",
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_hsl_without_function = true,
      enable_ansi = true,
      enable_var_usage = true,
      enable_tailwind = true,
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        ";f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep({
            additional_args = { "--hidden" },
          })
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "\\\\",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";t",
        function()
          local builtin = require("telescope.builtin")
          builtin.help_tags()
        end,
        desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        ";c",
        function()
          local builtin = require("telescope.builtin")
          builtin.lsp_incoming_calls()
        end,
        desc = "Lists LSP incoming calls for word under the cursor",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },

  {
    "stevearc/oil.nvim",
    opt = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    keys = {
      {
        "\\e",
        function()
          require("oil").open_float(nil, { preview = {} })
          -- require("oil").toggle_float()
        end,
      },
      {
        "\\E",
        function()
          require("oil").open()
        end,
      },
    },
    config = function()
      local oil = require("oil")

      oil.setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        -- trash_command = "trash-put",
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          -- Time to wait for LSP file operations to complete before skipping
          timeout_ms = 1000,
          -- Set to true to autosave buffers that are updated with LSP willRenameFiles
          -- Set to "unmodified" to only save unmodified buffers
          autosave_changes = false,
        },
        -- Constrain the cursor to the editable parts of the oil buffer
        -- Set to `false` to disable, or "name" to keep it on the file names
        constrain_cursor = "editable",
        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = true,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
          ["<C-p>"] = "actions.preview",
          -- ["<C-t>"] = '<cmd>lua require("oil").select({close=false, tab=true}, function() require("oil").open_float() end)<cr>',
          ["q"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["<S-H>"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 100,
          max_height = 30,
          border = "rounded",
          preview_split = "right",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        -- Configuration for the file preview window
        preview_win = {
          -- Whether the preview window is automatically updated when the cursor is moved
          update_on_cursor_moved = true,
        },
        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = { 100, 1 },
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 80, 0.8 },
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
          max_height = 0.9,
          -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
          min_height = { 5, 0.1 },
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
      })

      vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },

  {
    "0x00-ketsu/maximizer.nvim",
    config = function()
      require("maximizer").setup({
        vim.api.nvim_set_keymap(
          "n",
          "mx",
          '<cmd>lua require("maximizer").toggle()<CR>',
          { silent = true, noremap = true }
        ),
      })
    end,
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        buftypes = {},
        user_commands = true,
        options = {
          parsers = {
            css = true,
            names = { enable = false },
            hex = {
              default = true,
              rgb = true,
              rgba = true,
              rrggbb = true,
              rrggbbaa = true,
              aarrggbb = true,
            },
            rgb = { enable = true },
            hsl = { enable = true },
            tailwind = { enable = true, lsp = false },
            sass = { enable = true, parsers = { css = true } },
          },
          display = {
            mode = "background",
            virtualtext = {
              char = "■",
              position = "eol",
              hl_mode = "foreground",
            },
          },
          always_update = false,
        },
      })
    end,
  },

  {
    "anuvyklack/hydra.nvim",
    config = function()
      local Hydra = require("hydra")
      local cmd = require("hydra.keymap-util").cmd

      Hydra({
        name = "Resize Window",
        mode = { "n" },
        body = "<C-w>",
        config = {
          -- color = "pink",
        },
        heads = {
          -- resizing window
          { "H", "<C-w>2<", { noremap = true } },
          { "L", "<C-w>2>", { noremap = true } },
          { "K", "<C-w>2+", { noremap = true } },
          { "J", "<C-w>2-", { noremap = true } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })

      Hydra({
        name = "Side scroll",
        mode = "n",
        body = "z",
        heads = {
          { "h", "5zh" },
          { "l", "5zl", { desc = "←/→" } },
          { "H", "zH" },
          { "L", "zL", { desc = "half screen ←/→" } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })

      local telescopeHint = [[
 _f_: files       _m_: marks
 _o_: old files   _g_: live grep
 _p_: projects    _/_: search in file

 _r_: resume      _u_: undotree
 _h_: vim help    _c_: execute command
 _k_: keymaps     _;_: commands history
 _O_: options     _?_: search history
]]

      Hydra({
        name = "Telescope",
        hint = telescopeHint,
        config = {
          color = "teal",
          invoke_on_body = true,
          hint = {
            position = "middle",
            border = "rounded",
          },
        },
        mode = "n",
        body = "\\t",
        heads = {
          { "f", cmd("Telescope find_files") },
          { "g", cmd("Telescope live_grep") },
          { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
          { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
          { "m", cmd("MarksListBuf"), { desc = "marks" } },
          { "k", cmd("Telescope keymaps") },
          { "O", cmd("Telescope vim_options") },
          { "r", cmd("Telescope resume") },
          { "p", cmd("Telescope projects"), { desc = "projects" } },
          { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
          { "?", cmd("Telescope search_history"), { desc = "search history" } },
          { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
          { "c", cmd("Telescope commands"), { desc = "execute command" } },
          { "u", cmd("Telescope file_history history"), { desc = "undotree" } },
          { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })
    end,
  },

  {
    "mg979/vim-visual-multi",
  },

  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        astro = "<!-- %s -->",
        axaml = "<!-- %s -->",
        blueprint = "// %s",
        c = "// %s",
        c_sharp = "// %s",
        clojure = { ";; %s", "; %s" },
        cpp = "// %s",
        cs_project = "<!-- %s -->",
        cue = "// %s",
        fsharp = "// %s",
        fsharp_project = "<!-- %s -->",
        gleam = "// %s",
        glimmer = "{{! %s }}",
        graphql = "# %s",
        handlebars = "{{! %s }}",
        hcl = "# %s",
        html = "<!-- %s -->",
        hyprlang = "# %s",
        ini = "; %s",
        ipynb = "# %s",
        javascript = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
          template_string = "/* %s */", -- for styled components
        },
        kdl = "// %s",
        php = "// %s",
        rego = "# %s",
        rescript = "// %s",
        rust = { "// %s", "/* %s */" },
        sql = "-- %s",
        styled = "/* %s */",
        svelte = "<!-- %s -->",
        templ = {
          "// %s",
          component_block = "<!-- %s -->",
        },
        terraform = "# %s",
        tsx = {
          "// %s", -- default commentstring when no treesitter node matches
          "/* %s */",
          call_expression = "// %s", -- specific commentstring for call_expression
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
          template_string = "/* %s */", -- for styled components
        },
        twig = "{# %s #}",
        typescript = {
          "// %s",
          "/* %s */",
          template_string = "/* %s */", -- for styled components
        },
        typescriptreact = {
          "// %s",
          "/* %s */",
          call_expression = "// %s",
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
          template_string = "/* %s */", -- for styled components
        },
        javascriptreact = {
          "// %s",
          "/* %s */",
          call_expression = "// %s",
          jsx_attribute = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          spread_element = "// %s",
          statement_block = "// %s",
          template_string = "/* %s */", -- for styled components
        },
        vue = "<!-- %s -->",
        xaml = "<!-- %s -->",
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          winblend = vim.o.pumblend,
        },
      },
      signature = {
        window = {
          winblend = vim.o.pumblend,
        },
      },
    },
  },
}
