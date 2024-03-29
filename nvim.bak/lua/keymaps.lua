local keymap = vim.keymap

vim.g.mapleader = " "

-- q
keymap.set("n", "\\q", "<cmd>q<CR>", { silent = true, noremap = true })

-- ESC replace
keymap.set("i", "jk", "<ESC>", { silent = true })

-- Save all buffers
keymap.set("n", "<leader>w", ":wa<CR>", { silent = true, noremap = true })

-- Copy current buffer name and path
keymap.set("n", "cbp", ":let @+=@%<cr>", { desc = "Copy Buffer name and path" })

keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

-- codeium
keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true })

keymap.set("i", "<C-q>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true })

-- Do not yank with 'x'
keymap.set({ "n", "v" }, "x", '"_x')

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- New tab with Enter
keymap.set("n", "te", ":tabedit<Return>Enter", { silent = true })

-- Open new editor in this buffer
-- keymap.set("n", "ne", "<cmd>enew<cr>", { silent = true })

-- Buffer move
keymap.set("n", ";[", ":bprevious<CR>")
keymap.set("n", ";]", ":bnext<CR>")

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>j", { silent = true })
keymap.set("n", "sv", ":vsplit<Return><C-w>l", { silent = true })
keymap.set("n", "se", "<C-w>=")
keymap.set("n", "<leader>x", ":close<CR>")

-- Move window
keymap.set("", "<C-h>", "<C-w>h")
keymap.set("", "<C-k>", "<C-w>k")
keymap.set("", "<C-j>", "<C-w>j")
keymap.set("", "<C-l>", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Greatest remap ever ---> About paste
keymap.set("v", "p", '"_dP', { silent = true })

-- Move up & down with all of blocks
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Cursor don't move when press 'J'
keymap.set("n", "J", "mzJ`z", { silent = true })
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Modify all same text
keymap.set("n", "\\s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Search quickfix with vim grep
keymap.set("n", "\\v", [[:vim /\<<C-r><C-w>\>/ **<Left><Left>]])

--  Open quickfix navigation
keymap.set("n", "\\c", "<cmd>copen<CR>", { desc = "Open qfixlist" })

-- Navigate between quickfix items
keymap.set("n", "\\]", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
keymap.set("n", "\\[", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- Stay in indent-mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- foling
keymap.set("n", "-", "<cmd>foldclose<cr>", { desc = "Close code fold" })
keymap.set("n", "+", "<cmd>foldopen<cr>", { desc = "Open code fold" })
