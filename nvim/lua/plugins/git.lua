return {
  { "lewis6991/gitsigns.nvim" },

  { "tpope/vim-fugitive" },

  { "kdheepak/lazygit.nvim" },

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
    config = function()
      vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { silent = true })
      vim.keymap.set("n", "<leader>dmo", "<cmd>DiffviewOpen master<cr>", { silent = true })
      vim.keymap.set("n", "<leader>dq", "<cmd>DiffviewClose<cr>", { silent = true })

      vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<cr>", { silent = true })
      vim.keymap.set("n", "<leader>dmh", "<cmd>DiffviewFileHistory %<cr>", { silent = true })
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    -- co — choose ours
    -- ct — choose theirs
    -- cb — choose both
    -- c0 — choose none
    -- ]x — move to previous conflict
    -- [x — move to next conflict
  },
}
