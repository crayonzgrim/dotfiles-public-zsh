return {
  {
    "dinhhuy258/vim-local-history",
    enabled = true,
    config = function()
      -- 플러그인 설정 (필요에 따라 변경 가능)
      vim.g.local_history_path = vim.fn.stdpath("data") .. "/local_history"
      vim.g.local_history_width = 30
      vim.g.local_history_max_changes = 300
    end,
    cmd = { "LocalHistoryToggle", "LocalHistory" }, -- 명령어로 로드
    keys = {
      { "F5", "<cmd>LocalHistoryToggle<CR>", desc = "Toggle Local History" },
      -- Navigation keys
      -- { "j", "<cmd>lua require('local-history').move_older()<CR>", desc = "Move to older change", mode = "n" },
      -- { "k", "<cmd>lua require('local-history').move_newer()<CR>", desc = "Move to newer change", mode = "n" },
      -- { "G", "<cmd>lua require('local-history').move_oldest()<CR>", desc = "Move to oldest change", mode = "n" },
      -- { "gg", "<cmd>lua require('local-history').move_newest()<CR>", desc = "Move to newest change", mode = "n" },
      -- -- Revert change
      -- { "<CR>", "<cmd>lua require('local-history').revert()<CR>", desc = "Revert to selected change", mode = "n" },
      -- -- Diff
      -- { "r", "<cmd>lua require('local-history').diff()<CR>", desc = "Diff with selected change", mode = "n" },
      -- -- Delete change
      -- { "d", "<cmd>lua require('local-history').delete()<CR>", desc = "Delete selected change", mode = "n" },
      -- -- Graph size
      -- { "L", "<cmd>lua require('local-history').bigger()<CR>", desc = "Increase graph size", mode = "n" },
      -- { "H", "<cmd>lua require('local-history').smaller()<CR>", desc = "Decrease graph size", mode = "n" },
      -- -- Preview size
      -- { "K", "<cmd>lua require('local-history').preview_bigger()<CR>", desc = "Increase preview size", mode = "n" },
      -- { "J", "<cmd>lua require('local-history').preview_smaller()<CR>", desc = "Decrease preview size", mode = "n" },
      -- -- Quit
      -- { "q", "<cmd>lua require('local-history').quit()<CR>", desc = "Quit Local History", mode = "n" },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      menu = {
        width = 35,
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
    "leath-dub/snipe.nvim",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {},
    config = function(_, opts)
      require("snipe").setup({
        ui = {
          max_height = -1, -- -1 means dynamic height
          -- Where to place the ui window
          -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
          position = "topleft",
          -- Override options passed to `nvim_open_win`
          -- Be careful with this as snipe will not validate
          -- anything you override here. See `:h nvim_open_win`
          -- for config options
          open_win_override = {
            -- title = "My Window Title",
            border = "single", -- use "rounded" for rounded border
          },

          -- Preselect the currently open buffer
          preselect_current = true,

          -- Changes how the items are aligned: e.g. "<tag> foo    " vs "<tag>    foo"
          text_align = "left",
        },
        hints = {
          -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
          dictionary = "sadflewcmpghio",
        },
        navigate = {
          -- When the list is too long it is split into pages
          -- `[next|prev]_page` options allow you to navigate
          -- this list
          next_page = "J",
          prev_page = "K",

          -- You can also just use normal navigation to go to the item you want
          -- this option just sets the keybind for selecting the item under the
          -- cursor
          under_cursor = "<cr>",

          -- In case you changed your mind, provide a keybind that lets you
          -- cancel the snipe and close the window.
          cancel_snipe = "q",

          -- Close the buffer under the cursor
          -- Remove "j" and "k" from your dictionary to navigate easier to delete
          -- NOTE: Make sure you don't use the character below on your dictionary
          close_buffer = "D",

          -- Open buffer in vertical split
          open_vsplit = "V",

          -- Open buffer in split, based on `vim.opt.splitbelow`
          open_split = "S",

          -- Change tag manually
          change_tag = "C",
        },
        -- The default sort used for the buffers
        -- Can be any of "last", (sort buffers by last accessed) "default" (sort buffers by its number)
        sort = "default",
      })
    end,
  },
}
