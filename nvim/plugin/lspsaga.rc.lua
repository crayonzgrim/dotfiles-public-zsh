local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
    ui = {
        -- Currently, only the round theme exists
        theme = "round",
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "rounded",
        winblend = 5,
        expand = "",
        collapse = "",
        preview = " ",
        code_action = "💡",
        diagnostic = "🐞",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
        kind = {},
        colors = {
            normal_bg = "#002b36", -- #022746
        }
    }
})

-- local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_diagnostic<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>Lspsaga lsp_finder<CR>', opts)

vim.keymap.set("i", "<leader>h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
-- vim.keymap.set("n", "<C-a>", "<cmd>Lspsaga code_action<CR>", opts)

vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)

-- code action
local codeaction = require("lspsaga.codeaction")
vim.keymap.set("n", "<leader>a", function() codeaction:code_action() end, { silent = true })
vim.keymap.set("v", "<leader>a", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_code_action()
end, { silent = true })
