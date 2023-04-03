vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.termguicolors = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.opt.clipboard:append({ "unnamedplus" })

-- vim.cmd("autocmd!")
--
-- vim.scriptencoding = "utf-8"
-- vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"
--
-- local opt = vim.opt
--
-- -- set basic
-- opt.shell = "zsh"
-- opt.title = true
--
-- -- scroll moving off
-- opt.scrolloff = 4 -- Lines of context
-- opt.sidescrolloff = 8 -- Columns of context
--
-- -- line numbers
-- opt.relativenumber = true
-- opt.number = true
--
-- -- tabs & indentation
-- opt.tabstop = 2
-- opt.shiftwidth = 2
-- opt.autoindent = true
-- opt.smartindent = true
--
-- -- line wrapping
-- opt.wrap = false
-- opt.linebreak = true -- Stop words being broken on wrap
--
-- -- search settings
-- opt.ignorecase = true
-- opt.smartcase = true
-- opt.incsearch = true -- Shows the match while typing
-- opt.joinspaces = false -- No double spaces with join
--
-- -- cursor
-- opt.cursorline = true
--
-- -- appearance (highlights)
-- opt.termguicolors = true
-- opt.winblend = 0
-- opt.wildoptions = "pum"
-- opt.pumblend = 5
-- opt.background = "dark"
-- opt.signcolumn = "yes"
-- opt.hlsearch = true
--
-- -- backspace
-- opt.backspace = { "start", "eol", "indent" }
--
-- -- clipboard
-- opt.clipboard:append({ "unnamedplus" })
--
-- -- split windows
-- opt.inccommand = "split"
--
-- opt.wildignore:append({ "*/node_modules/*" })
--
-- -- Turn off paste mode when leaving insert
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	pattern = "*",
-- 	command = "set nopaste",
-- })
--
-- -- Add asterisks in block comments
-- opt.formatoptions:append({ "r" })
--
-- -- Faster scrolling
-- opt.lazyredraw = true
--
-- -- Remember history
-- opt.history = 100
--
-- -- Add exatra...
-- opt.swapfile = false
-- opt.showcmd = true
-- opt.cmdheight = 1
-- opt.updatetime = 100 -- faster completion (40000ms default)
-- opt.conceallevel = 0 -- so that `` is visibvle in markdown files
-- opt.laststatus = 2
-- opt.expandtab = true
-- opt.smarttab = true
-- opt.breakindent = true
-- -- opt.path:append { '**' } -- Finding files - Search down into subfolders
--
-- -- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])
--
-- -- highlight yanked text for 200ms using the "Visual" highlight group
-- vim.cmd([[
--   augroup highlight_yank
--   autocmd!
--   au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
--   augroup END
-- ]])
