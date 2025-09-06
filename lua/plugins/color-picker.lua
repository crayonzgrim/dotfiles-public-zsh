return {
  "ziontee113/color-picker.nvim",
  enable = true,
  config = function()
    local picker = require("color-picker")

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "\\c", "<cmd>PickColor<cr>", opts)
    vim.keymap.set("i", "\\c", "<cmd>PickColorInsert<cr>", opts)

    -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
    -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

    picker.setup({
      -- for changing icons & mappings
      ["icons"] = { "", "🎨" },
      -- ["icons"] = { "ﮊ", "" },
      -- ["icons"] = { "", "ﰕ" },
      -- ["icons"] = { "", "" },
      -- ["icons"] = { "", "" },
      -- ["icons"] = { "ﱢ", "" },
      ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
      ["keymap"] = { -- mapping example:
        ["U"] = "<Plug>ColorPickerSlider5Decrease",
        ["O"] = "<Plug>ColorPickerSlider5Increase",
      },
      ["background_highlight_group"] = "Normal", -- default
      ["border_highlight_group"] = "FloatBorder", -- default
      ["text_highlight_group"] = "Normal", --default
    })

    vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
  end,
}
