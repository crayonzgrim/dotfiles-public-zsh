return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>yc",
      function()
        require("yazi").yazi()
      end,
      desc = "Open the file manager",
    },
    {
      -- Open in the current working directory
      "<leader>yz",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 0.8,
  },
}
