return {
  { "nvim-lua/plenary.nvim" },

  {
    "ThePrimeagen/harpoon",
    -- branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set(
        "n",
        "<leader>ha",
        "<cmd>lua require('harpoon.mark').add_file()<cr>",
        { desc = "Mark file with harpoon" }
      )
      keymap.set(
        "n",
        "<leader>ho",
        "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        { desc = "Open harpoon quick menu" }
      )
      keymap.set("n", "sh", "<cmd>Telescope harpoon marks<cr>", { desc = "Harpoon in Telescope" })
      keymap.set(
        "n",
        "<leader>hn",
        "<cmd>lua require('harpoon.ui').nav_next()<cr>",
        { desc = "Go to next harpoon mark" }
      )
      keymap.set(
        "n",
        "<leader>hp",
        "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
        { desc = "Go to prev harpoon mark" }
      )
    end,
  },

  {
    "jiaoshijie/undotree",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local undotree = require("undotree")

      undotree.setup({
        float_diff = true, -- using float window previews diff, set this `true` will disable layout option
        layout = "left_left_bottom", -- "left_bottom", "left_left_bottom"
        ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
        window = {
          winblend = 5,
        },
        keymaps = {
          ["j"] = "move_next",
          ["k"] = "move_prev",
          ["J"] = "move_change_next",
          ["K"] = "move_change_prev",
          ["<cr>"] = "action_enter",
          ["p"] = "enter_diffbuf",
          ["q"] = "quit",
        },
      })

      vim.keymap.set("n", "\\u", require("undotree").toggle, { noremap = true, silent = true })
      --
      -- Enable undofile and specify undodir
      local config_dir = vim.fn.stdpath("config")

      vim.opt.undofile = true
      vim.opt.undodir = config_dir .. "~/.config/nvim/undodir"
      vim.opt.undolevels = 100
    end,
  },
}
