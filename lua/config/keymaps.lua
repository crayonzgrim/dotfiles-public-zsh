local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- q
keymap.set("n", "\\q", "<cmd>q<CR>", opts)

-- ESC replace
keymap.set("i", "jk", "<ESC>", opts)

-- Save all buffers
keymap.set("n", "<C-s>", ":wa<CR>", opts)

-- Copy current file name and path
-- keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
-- keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path Name" })
keymap.set("n", "<leader>cf", function()
  -- 현재 파일의 절대 경로
  local abs_path = vim.fn.expand("%:p")
  -- cwd 기준 상대 경로
  local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")
  vim.fn.setreg("+", rel_path)
  vim.notify("Copied relative path: " .. rel_path, vim.log.levels.INFO)
end, { desc = "Copy File Name (relative to root)" })

keymap.set("n", "<leader>cp", function()
  local abs_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", abs_path)
  vim.notify("Copied absolute path: " .. abs_path, vim.log.levels.INFO)
end, { desc = "Copy Absolute File Path" })

-- Move normally even if multiple lines
keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

-- Do not yank with 'x'
keymap.set({ "n", "v" }, "x", '"_x')

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')

-- 특정 단어만 검색
keymap.set("n", "<leader>/", "/\\<\\><Left><Left>", { desc = "Search exact word" })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-p>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<Return>Enter", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "se", "<C-w>=")

-- Move window
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize window
-- vim.api.nvim_set_keymap("n", "<C-w><left>", ":vertical resize -5<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<C-w><right>", ":vertical resize +5<CR>", opts)
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Q macro
keymap.set("n", "Q", "@qj")
keymap.set("x", "Q", ":norm @q<CR>")

-- Greatest remap ever-1 ---> About paste
keymap.set("v", "p", '"_dP', { silent = true })

-- Greatest remap ever-2 ---> Move up & down with all of blocks
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Greatest remap ever-3 ---> Cursor don't move
keymap.set("n", "J", "mzJ`z", { silent = true })
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Greatest remap ever-4 ---> Stay in indent-mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- foling
-- keymap.set("n", "_", "<cmd>foldclose<cr>", { desc = "Close code fold" })
-- keymap.set("n", "+", "<cmd>foldopen<cr>", { desc = "Open code fold" })

-- Diagnostics
-- local diagnostic_goto = function(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
-- keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
-- keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Modify all same text
keymap.set("n", "\\s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Search quickfix with vim grep
keymap.set("n", "<leader>qf", [[:vim /\<<C-r><C-w>\>/ **<Left><Left>]])
--  Open quickfix navigation
keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open qfixlist" })
-- Navigate between quickfix items
-- keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
-- keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

keymap.set("n", "<leader>r", function()
  require("crayonzgrim.hsl").replaceHexWithHSL()
end)
keymap.set("n", "<leader>i", function()
  require("crayonzgrim.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
  require("crayonzgrim.lsp").toggleAutoformat()
end, {})
