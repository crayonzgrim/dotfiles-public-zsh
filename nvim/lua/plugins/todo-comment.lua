return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  cmd = { "TodoQuickFix" },
  keys = {
    { "<leader>td", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  },
}
