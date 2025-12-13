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

-- 현재 파일의 절대 경로
keymap.set("n", "<leader>cf", function()
  local abs_path = vim.fn.expand("%:p")
  local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")
  vim.fn.setreg("+", rel_path)
  vim.notify("Copied relative path: " .. rel_path, vim.log.levels.INFO)
end, { desc = "Copy File Name (relative to root)" })

-- cwd 기준 상대 경로
keymap.set("n", "<leader>cp", function()
  local abs_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", abs_path)
  vim.notify("Copied absolute path: " .. abs_path, vim.log.levels.INFO)
end, { desc = "Copy Absolute File Path" })

-- Move normally even if multiple lines
keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Do not yank with 'x'
keymap.set({ "n", "v" }, "x", '"_x')

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- 특정 단어만 검색
keymap.set("n", "<leader>/", "/\\<\\><Left><Left>", { desc = "Search exact word" })

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

-- Q macro
keymap.set("n", "Q", "@qj")
keymap.set("x", "Q", ":norm @q<CR>")

keymap.set("n", "\\s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Search quickfix with vim grep
keymap.set("n", "<leader>qf", [[:vim /\<<C-r><C-w>\>/ **<Left><Left>]])
--  Open quickfix navigation
keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open qfixlist" })

keymap.set("n", "<leader>r", function()
  require("crayonzgrim.hsl").replaceHexWithHSL()
end)
keymap.set("n", "<leader>i", function()
  require("crayonzgrim.lsp").toggleInlayHints()
end)

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
