return {
  "dart-lang/dart-vim-plugin",
  event = "VeryLazy",
  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>df", "<cmd>DartFmt<cr>", { noremap = true })
  end,
}
