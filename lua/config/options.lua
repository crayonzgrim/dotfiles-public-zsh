vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.linebreak = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- backups
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 5
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "nosplit"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartcase = true
vim.opt.ignorecase = true -- keymap Keymap
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({
  -- JS, TS
  "**/node_modules/*",
  "**/.next/*",
  -- GIT
  "**/.git/*",
  -- Mobile
  "**/ios/*",
  "**/android/*",
  -- Python
  "**/.pyc",
  -- Rust
  "**/target/",
})
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a" -- 마우스 지원 활성화
vim.opt.wildmode = "longest:full,full" -- 명령줄 자동 완성 동작

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- File types
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"
