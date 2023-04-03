local keymap = vim.keymap

-- ESC replace
keymap.set("i", "jk", "<ESC>")

-- Do not yank with 'x'
keymap.set("n", "x", '"_x')

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- New tab with Enter
keymap.set("n", "te", ":tabedit<Return>Enter", { silent = true })

-- Buffer move
keymap.set("n", ";b", ":bprevious<CR>")
keymap.set("n", ";n", ":bnext<CR>")

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })
keymap.set("n", "se", "<C-w>=")
keymap.set("n", "<leader>x", ":close<CR>")

-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Greatest remap ever ---> About paste
keymap.set("x", "<leader>p", '"_dP')

-- Move up & down with all of blocks
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor don't move when press 'J'
keymap.set("n", "J", "mzJ`z")
