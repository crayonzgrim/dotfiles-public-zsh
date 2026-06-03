return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- biome = {
      --   typescript = { "biome" },
      --   typescriptreact = { "biome" },
      --   javascript = { "biome" },
      --   javascriptreact = { "biome" },
      --   json = { "biome" },
      --   css = { "biome" },
      -- },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
    },
  },
}
