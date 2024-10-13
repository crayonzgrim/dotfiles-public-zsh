return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      menu = {
        width = 50,
        -- width = vim.api.nvim_win_get_width(0) - 8,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>ho",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
        {
          "<leader>hn",
          function()
            local harpoon = require("harpoon")
            harpoon:list():next()
          end,
        },
        {
          "<leader>hp",
          function()
            local harpoon = require("harpoon")
            harpoon:list():prev()
          end,
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },

  {
    "jiaoshijie/undotree",
    enabled = true,
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
      vim.opt.undodir = config_dir .. "~/.config/nvim/undodir"
      vim.opt.undolevels = 300
    end,
  },
}
