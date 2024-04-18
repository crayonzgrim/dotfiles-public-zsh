return {
  {
    "ggandor/flit.nvim",
    enabled = false,
    dependencies = {
      "ggandor/leap.nvim",
      "tpope/vim-repeat",
    },
    keys = function()
      -- @type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },

  {
    "folke/flash.nvim",
    enabled = true,
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("solarized-osaka.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
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
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
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
      require("telescope").load_extension("harpoon")
      require("telescope").load_extension("flutter")
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    enabled = true,
    event = "VeryLazy",

    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Window Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Window Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Window Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Window Right" },
    },
  },

  {
    "szw/vim-maximizer",
    config = function()
      vim.keymap.set("n", "<leader>mx", ":MaximizerToggle<CR>", { silent = true }) -- toggle split window maximization
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          local ignore_folders = { "node_modules", "dist", "build", "coverage" }
          return vim.startswith(name, ".") or vim.tbl_contains(ignore_folders, name)
        end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        padding = 2,
        max_width = 120,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      -- Custom Keymap
      keymaps = {
        ["<C-c>"] = false,
        ["<C-s>"] = "actions.save",
        ["q"] = "actions.close",
        ["<C-y>"] = "actions.copy_entry_path",
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Use g? to see default key mappings
    keys = {
      {
        "\\e",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open file explorer",
      },
    },
  },
  -- {
  --   "stevearc/oil.nvim",
  --   opt = {},
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   keys = {
  --     {
  --       "\\e",
  --       function()
  --         require("oil").toggle_float()
  --       end,
  --       desc = "Toggle Oil",
  --     },
  --   },
  -- },

  {
    "Exafunction/codeium.vim",
  },

  {
    "barrett-ruth/live-server.nvim",
    build = "pnpm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}
