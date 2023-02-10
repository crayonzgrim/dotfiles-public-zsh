local status, mason = pcall(require, "mason")
if not status then
  return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

mason.setup({})

lspconfig.setup({
    -- ensure_installed = {
    --     "tsserver",
    --     "html",
    --     "cssls",
    --     "tailwindcss",
    --     "sumneko_lua",
    --     -- "emmet_ls",
    -- },
    automatic_installation = true,
})

mason_null_ls.setup({
    -- list of formatters & linters for mason to install
    ensure_installed = {
        "prettierd", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
    },
    -- auto-install configured formatters & linters (with null-ls)
    automatic_installation = true,
})
