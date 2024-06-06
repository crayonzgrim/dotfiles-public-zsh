return {
  {
    "ggandor/flit.nvim",
    enabled = true,
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
    enabled = false,
    opts = {
      modes = {
        search = {
          enabled = false,
        },
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
          -- pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          -- group = function(_, match)
          --   local utils = require("solarized-osaka.hsl")
          --   --- @type string, string, string
          --   local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
          --   --- @type number?, number?, number?
          --   local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
          --   --- @type string
          --   local hex_color = utils.hslToHex(h, s, l)
          --   return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          -- end,
        },
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
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
    -- "telescope.nvim",
    -- branch = "0.1.x",
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    --   "nvim-tree/nvim-web-devicons",
    --   "folke/todo-comments.nvim",
    --   "nvim-telescope/telescope-file-browser.nvim",
    -- },
    -- -- keys = {
    -- --   {
    -- --     "<leader>fP",
    -- --     function()
    -- --       require("telescope.builtin").find_files({
    -- --         cwd = require("lazy.core.config").options.root,
    -- --       })
    -- --     end,
    -- --     desc = "Find Plugin File",
    -- --   },
    -- --   {
    -- --     ";f",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.find_files({
    -- --         no_ignore = true,
    -- --         hidden = true,
    -- --       })
    -- --     end,
    -- --     desc = "Lists files in your current working directory, respects .gitignore",
    -- --   },
    -- --   {
    -- --     ";r",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.live_grep({
    -- --         file_ignore_patterns = { "node_modules" }, -- Exclude node_modules directory
    -- --       })
    -- --     end,
    -- --     desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    -- --   },
    -- --   {
    -- --     "\\\\",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.buffers()
    -- --     end,
    -- --     desc = "Lists open buffers",
    -- --   },
    -- --   {
    -- --     ";t",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.help_tags()
    -- --     end,
    -- --     desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
    -- --   },
    -- --   {
    -- --     ";;",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.resume()
    -- --     end,
    -- --     desc = "Resume the previous telescope picker",
    -- --   },
    -- --   {
    -- --     ";e",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.diagnostics()
    -- --     end,
    -- --     desc = "Lists Diagnostics for all open buffers or a specific buffer",
    -- --   },
    -- --   {
    -- --     ";s",
    -- --     function()
    -- --       local builtin = require("telescope.builtin")
    -- --       builtin.treesitter()
    -- --     end,
    -- --     desc = "Lists Function names, variables, from Treesitter",
    -- --   },
    -- --   {
    -- --     "sf",
    -- --     function()
    -- --       local telescope = require("telescope")
    -- --
    -- --       local function telescope_buffer_dir()
    -- --         return vim.fn.expand("%:p:h")
    -- --       end
    -- --
    -- --       telescope.extensions.file_browser.file_browser({
    -- --         path = "%:p:h",
    -- --         cwd = telescope_buffer_dir(),
    -- --         respect_gitignore = false,
    -- --         hidden = true,
    -- --         grouped = true,
    -- --         previewer = false,
    -- --         initial_mode = "normal",
    -- --         layout_config = { height = 40 },
    -- --       })
    -- --     end,
    -- --     desc = "Open File Browser with the path of the current buffer",
    -- --   },
    -- -- },
    -- config = function(_, opts)
    --   local telescope = require("telescope")
    --   local actions = require("telescope.actions")
    --   local fb_actions = require("telescope").extensions.file_browser.actions
    --
    --   local transform_mod = require("telescope.actions.mt").transform_mod
    --   local trouble = require("trouble")
    --   local trouble_telescope = require("trouble.providers.telescope")
    --
    --   local custom_actions = transform_mod({
    --     open_trouble_qflist = function(prompt_bufnr)
    --       trouble.toggle("quickfix")
    --     end,
    --   })
    --
    --   telescope.setup({
    --     defaults = {
    --       path_display = { "smart" },
    --       mappings = {
    --         i = {
    --           ["<C-k>"] = actions.move_selection_previous, -- move to prev result
    --           ["<C-j>"] = actions.move_selection_next, -- move to next result
    --           ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
    --           ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
    --         },
    --       },
    --     },
    --   })
    --
    --   telescope.load_extension("fzf")
    --
    --   -- set keymaps
    --   local keymap = vim.keymap -- for conciseness
    --
    --   -- keymap.set("n", ";f", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    --   keymap.set("n", ";f", function()
    --     local builtin = require("telescope.builtin")
    --     builtin.find_files({
    --       no_ignore = true,
    --       hidden = false,
    --     })
    --   end, { desc = "Lists files in your current working directory, respects .gitignore" })
    --   keymap.set("n", ";o", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    --   -- keymap.set("n", ";r", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    --   keymap.set("n", ";r", function()
    --     local builtin = require("telescope.builtin")
    --     builtin.live_grep({
    --       file_ignore_patterns = { "node_modules" }, -- Exclude node_modules directory
    --     })
    --   end, {
    --     desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    --   })
    --   keymap.set("n", ";gs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    --   keymap.set("n", ";td", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    --   keymap.set("n", "\\\\", function()
    --     local builtin = require("telescope.builtin")
    --     builtin.buffers()
    --   end, { desc = "Lists open buffers" })
    --   keymap.set("n", ";;", function()
    --     local builtin = require("telescope.builtin")
    --     builtin.resume()
    --   end, { desc = "Resume the previous telescope picker" })
    --   keymap.set("n", ";e", function()
    --     local builtin = require("telescope.builtin")
    --     builtin.diagnostics()
    --   end, { desc = "Lists Diagnostics for all open buffers or a specific buffer" })
    --   keymap.set("n", "sf", function()
    --     local function telescope_buffer_dir()
    --       return vim.fn.expand("%:p:h")
    --     end
    --
    --     telescope.extensions.file_browser.file_browser({
    --       path = "%:p:h",
    --       cwd = telescope_buffer_dir(),
    --       respect_gitignore = false,
    --       hidden = false,
    --       grouped = true,
    --       previewer = true,
    --       initial_mode = "normal",
    --       layout_config = { height = 40 },
    --     })
    --   end, { desc = "Open File Browser with the path of the current buffer" })
    --
    --   -- opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
    --   --   wrap_results = true,
    --   --   layout_strategy = "horizontal",
    --   --   layout_config = { prompt_position = "top" },
    --   --   sorting_strategy = "ascending",
    --   --   winblend = 0,
    --   --   mappings = {
    --   --     n = {},
    --   --   },
    --   -- })
    --   -- opts.pickers = {
    --   --   diagnostics = {
    --   --     theme = "ivy",
    --   --     initial_mode = "normal",
    --   --     layout_config = {
    --   --       preview_cutoff = 9999,
    --   --     },
    --   --   },
    --   -- }
    --   -- opts.extensions = {
    --   --   file_browser = {
    --   --     theme = "dropdown",
    --   --     -- disables netrw and use telescope-file-browser in its place
    --   --     hijack_netrw = true,
    --   --     mappings = {
    --   --       -- your custom insert mode mappings
    --   --       ["n"] = {
    --   --         -- your custom normal mode mappings
    --   --         ["N"] = fb_actions.create,
    --   --         ["h"] = fb_actions.goto_parent_dir,
    --   --         ["/"] = function()
    --   --           vim.cmd("startinsert")
    --   --         end,
    --   --         ["<C-u>"] = function(prompt_bufnr)
    --   --           for i = 1, 10 do
    --   --             actions.move_selection_previous(prompt_bufnr)
    --   --           end
    --   --         end,
    --   --         ["<C-d>"] = function(prompt_bufnr)
    --   --           for i = 1, 10 do
    --   --             actions.move_selection_next(prompt_bufnr)
    --   --           end
    --   --         end,
    --   --         ["<PageUp>"] = actions.preview_scrolling_up,
    --   --         ["<PageDown>"] = actions.preview_scrolling_down,
    --   --       },
    --   --     },
    --   --   },
    --   -- }
    --   telescope.setup(opts)
    --   require("telescope").load_extension("fzf")
    --   require("telescope").load_extension("file_browser")
    --   require("telescope").load_extension("harpoon")
    --   require("telescope").load_extension("flutter")
    -- end,
  },
  {
    "christoomey/vim-tmux-navigator",
    enabled = true,
    event = "VeryLazy",
    -- keys = {
    --   {
    --     "<C-k>",
    --     function()
    --       require("tmux-navigator").NvimTmuxNavigateUp()
    --     end,
    --     desc = { "TmuxNavigateUp" },
    --   },
    --   {
    --     "<C-j>",
    --     function()
    --       require("tmux-navigator").NvimTmuxNavigateDown()
    --     end,
    --     desc = { "TmuxNavigateDown" },
    --   },
    --   {
    --     "<C-h>",
    --     function()
    --       require("tmux-navigator").NvimTmuxNavigateLeft()
    --     end,
    --     desc = { "TmuxNavigateLeft" },
    --   },
    --   {
    --     "<C-l>",
    --     function()
    --       require("tmux-navigator").NvimTmuxNavigateRight()
    --     end,
    --     desc = { "TmuxNavigateRight" },
    --   },
    --   {
    --     "<C-\\>",
    --     function()
    --       require("tmux-navigator").NvimTmuxNavigatePrevious()
    --     end,
    --     desc = { "TmuxNavigatePrevious" },
    --   },
    -- },
  },
  {
    "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
  },
  {
    "szw/vim-maximizer",
    config = function()
      vim.keymap.set("n", "<leader>mx", ":MaximizerToggle<CR>", { silent = true }) -- toggle split window maximization
    end,
  },
  {
    "stevearc/oil.nvim",
    opt = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "\\e",
        function()
          require("oil").toggle_float()
        end,
      },
      {
        "<leader>o",
        function()
          require("Oil")
        end,
      },
    },
    config = function()
      local oil = require("oil")

      oil.setup({
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you still want to use netrw.
        default_file_explorer = true,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
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
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = false,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = true,
        -- Change this to customize the command used when deleting to trash
        trash_command = "trash-put",
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["q"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
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
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return false
          end,
          sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 5,
          max_width = 100,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = 0.9,
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 40, 0.4 },
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
    "Exafunction/codeium.vim",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
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
