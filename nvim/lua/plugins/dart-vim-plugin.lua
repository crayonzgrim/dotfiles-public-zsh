return {
  "dart-lang/dart-vim-plugin",
  event = "VeryLazy",
  config = function()
    local keymap = vim.keymap -- for conciseness

    -- flutter prettier
    keymap.set("n", "<leader>fp", "<cmd>DartFmt<cr>", { noremap = true })
  end,
}
