return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      global_settings = {
        -- sets the marks upon calling 'toggle' on the ui, instead of require ":w"
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling 'sendCommand'
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_window = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository.
        -- Each branch will have it's own set of marked files.
        mark_branch = true,

        -- Enable tabline with harpoon marks.
        tabline = false,
        tabline_prefix = " ",
        tabline_suffix = " ",
      }

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark file with harpoon" })
      keymap.set(
        "n",
        "ho",
        "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        { desc = "Open harpoon quick menu" }
      )
      keymap.set("n", "sh", "<cmd>Telescope harpoon marks<cr>", { desc = "Harpoon in Telescope" })
      keymap.set("n", "hn", require("harpoon.ui").nav_next, { desc = "Next mark file on harpoon" })
      keymap.set("n", "hp", require("harpoon.ui").nav_prev, { desc = "Previous mark file on harpoon" })
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
        layout = "left_bottom", -- "left_bottom", "left_left_bottom"
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
      vim.opt.undodir = config_dir .. "/.config/nvim/undodir"
      vim.opt.undolevels = 300
    end,
  },
}
