return {
  "lewis6991/gitsigns.nvim",

  "tpope/vim-fugitive",

  "kdheepak/lazygit.nvim",

  { "akinsho/git-conflict.nvim", version = "*", config = true },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
        -- Close blame window
        quit_blame = "q",
        -- Opens a new diff that compares against the current index
        diff = "<Leader>gd",
        -- Close git diff
        diff_close = "<Leader>q",
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    keys = {

      { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
      { "<leader>dmh", "<cmd>DiffviewFileHistory %<cr>", desc = "File master history" },

      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
      { "<leader>dmo", "<cmd>DiffviewOpen master<cr>", desc = "Diff view master view" },
      { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Diff view close" },
    },
    -- opts = function()
    --   local actions = require("diffview.actions")
    --
    --   require("diffview.ui.panel").Panel.default_config_float.border = "rounded"
    --
    --   return {
    --     default_args = { DiffviewFileHistory = { "%" } },
    --     icons = {
    --       folder_closed = icons.symbol_kinds.Folder,
    --       folder_open = "󰝰",
    --     },
    --     signs = {
    --       fold_closed = icons.arrows.right,
    --       fold_open = icons.arrows.down,
    --       done = "",
    --     },
    --     -- Disable mappings I don't use and use ? instead of g? for help.
    --     keymaps = {
    --       view = {
    --         ["<C-w><C-f>"] = false,
    --         ["<leader>e"] = false,
    --       },
    --       diff1 = {
    --         ["g?"] = false,
    --         { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    --       },
    --       diff2 = {
    --         ["g?"] = false,
    --         { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    --       },
    --       diff3 = {
    --         ["g?"] = false,
    --         { "n", "?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
    --       },
    --       diff4 = {
    --         ["g?"] = false,
    --         { "n", "?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
    --       },
    --       file_panel = {
    --         ["<down>"] = false,
    --         ["<up>"] = false,
    --         ["o"] = false,
    --         ["l"] = false,
    --         ["<2-LeftMouse>"] = false,
    --         ["-"] = false,
    --         ["h"] = false,
    --         ["<C-w><C-f>"] = false,
    --         ["<leader>e"] = false,
    --         ["g?"] = false,
    --         { "n", "?", actions.help("file_panel"), { desc = "Open the help panel" } },
    --       },
    --       file_history_panel = {
    --         ["<C-A-d>"] = false,
    --         ["h"] = false,
    --         ["<down>"] = false,
    --         ["<up>"] = false,
    --         ["o"] = false,
    --         ["l"] = false,
    --         ["<2-LeftMouse>"] = false,
    --         ["<C-w><C-f>"] = false,
    --         ["<leader>e"] = false,
    --         ["g?"] = false,
    --         ["g!"] = false,
    --         { "n", "?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
    --         { "n", "!", actions.options, { desc = "Open the option panel" } },
    --         {
    --           "n",
    --           "<leader>d",
    --           actions.open_in_diffview,
    --           { desc = "Open the entry under the cursor in a diffview" },
    --         },
    --       },
    --       option_panel = {
    --         ["g?"] = false,
    --         { "n", "?", actions.help("option_panel"), { desc = "Open the help panel" } },
    --       },
    --     },
    --   }
    -- end,
  },
}
