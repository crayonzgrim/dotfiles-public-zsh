local keymap = vim.keymap

-- ESC replace
keymap.set("i", "jk", "<ESC>", { silent = true })

-- Save all buffers
-- keymap.set("n", "<leader>w", "<cmd>wa<cr>")

keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

-- codeium
keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true })

keymap.set("i", "<C-[>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true })

keymap.set("i", "<C-]>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true })

keymap.set("i", "<C-q>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true })

-- Do not yank with 'x'
keymap.set("n", "x", '"_x')
keymap.set("v", "x", '"_x')

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- New tab with Enter
keymap.set("n", "te", ":tabedit<Return>Enter", { silent = true })

-- Buffer move
keymap.set("n", ";[", ":bprevious<CR>")
keymap.set("n", ";]", ":bnext<CR>")

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

-- Modify all same text
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
