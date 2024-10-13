return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  optional = true,
  opts = function(_, opts)
    -- 기본 포맷 옵션 설정
    -- opts.format = opts.format
    opts.default_format_opts = opts.default_format_opts
      or {
        timeout_ms = 1000,
        async = false, -- not recommended to change
        lsp_fallback = true, -- not recommended to change
      }

    -- 파일 형식별 포맷터 설정
    opts.formatters_by_ft = opts.formatters_by_ft
      or {
        sh = { "shfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      }

    opts.formatters = opts.formatters
      or {
        prettier = {
          condition = function(_, ctx)
            return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
          end,
        },
      }
  end,
}
