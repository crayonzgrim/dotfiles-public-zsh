vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

local opt = vim.opt

-- set basic
opt.title = true
vim.opt.shell = "zsh"
opt.expandtab = true
-- opt.showcmd = true
-- opt.cmdheight = 1
-- opt.laststatus = 2

-- scroll moving off
opt.scrolloff = 5

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor
opt.cursorline = true

-- appearance (highlights)
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = "pum"
opt.pumblend = 5
opt.background = "dark"
opt.signcolumn = "yes"
opt.hlsearch = true

-- backspace
opt.backspace = { "start", "eol", "indent" }

-- clipboard
opt.clipboard:append { "unnamedplus" }

-- split windows
opt.inccommand = "split"
opt.splitright = true
opt.splitbelow = true

vim.opt.wildignore:append { '*/node_modules/*' }

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = '*',
    command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]
