local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- q
keymap.set("n", "\\q", "<cmd>q<CR>", opts)

-- ESC replace
keymap.set("i", "jk", "<ESC>", opts)

-- Save all buffers
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("n", "<C-w>", ":wa<CR>", opts)

-- Copy current buffer name and path
keymap.set("n", "cbp", ":let @+=@%<cr>", { desc = "Copy Buffer name and path" })

-- Move normally even if multiple lines
keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

-- Do not yank with 'x'
keymap.set({ "n", "v" }, "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<Return>Enter", opts)
keymap.set("n", "}", ":tabnext<Return>", opts)
keymap.set("n", "{", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "se", "<C-w>=")
keymap.set("n", "<leader>x", ":close<CR>")
-- Move window
-- keymap.set("n", "sh", "<C-w>h")
-- keymap.set("n", "sk", "<C-w>k")
-- keymap.set("n", "sj", "<C-w>j")
-- keymap.set("n", "sl", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-l>", "<C-w>l")

-- codeium
keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })

keymap.set("i", "<C-q>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true })

-- Resize window
-- keymap.set("n", "<C-w><left>", "<C-w><")
-- keymap.set("n", "<C-w><right>", "<C-w>>")
-- keymap.set("n", "<C-w><up>", "<C-w>+")
-- keymap.set("n", "<C-w><down>", "<C-w>-")

-- Greatest remap ever-1 -> About paste
keymap.set("v", "p", '"_dP', { silent = true })

-- Greatest remap ever-2 ---> Move up & down with all of blocks
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Greatest remap ever-3 -> Cursor don't move
keymap.set("n", "J", "mzJ`z", { silent = true })
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Greatest remap ever-4 -> Stay in indent-mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- foling
keymap.set("n", "-", "<cmd>foldclose<cr>", { desc = "Close code fold" })
keymap.set("n", "+", "<cmd>foldopen<cr>", { desc = "Open code fold" })

-- Modify all same text
keymap.set("n", "\\s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Search quickfix with vim grep
keymap.set("n", "\\v", [[:vim /\<<C-r><C-w>\>/ **<Left><Left>]])
--  Open quickfix navigation
keymap.set("n", "<leader>c", "<cmd>copen<CR>", { desc = "Open qfixlist" })
-- Navigate between quickfix items
keymap.set("n", "\\]", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
keymap.set("n", "\\[", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

keymap.set("n", "<leader>r", function()
  require("crayonzgrim.utils").replaceHexWithHSL()
end)

keymap.set("n", "Q", "@qj")
keymap.set("x", "Q", ":norm @q<CR>")
