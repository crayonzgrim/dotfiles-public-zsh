return {
  "nvim-neo-tree/neo-tree.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "echasnovski/mini.icons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<cr>", silent = true, desc = "Neotree" },
    { "<leader>E", "<cmd>Neotree toggle reveal_force_cwd<cr>", silent = true, desc = "Neotree" },
    { "<leader><tab>", "<cmd>Neotree toggle float<cr>", silent = true, desc = "Float file explorer" },
  },
  config = function()
    require("neo-tree").setup({
      enable_git_status = true,
      enable_diagnostics = true,
      use_libuv_file_watcher = true,
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".yarn",
            ".git",
            ".github",
            ".DS_Store",
            "thumbs.db",
          },
          always_show_by_pattern = { -- uses glob style patterns
            ".env",
            ".env.*",
          },
          never_show = {},
        },
      },
    })

    -- vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
  end,
}
