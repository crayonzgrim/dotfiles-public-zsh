-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- vim-fugitive 색상 설정
-- vim.cmd("highlight link DiffAdd GitsignsAdd")
-- vim.cmd("highlight link DiffChange GitsignsChange")
-- vim.cmd("highlight link DiffDelete GitsignsDelete")
-- vim.cmd("highlight link DiffText GitsignsChange")

-- vim.cmd("highlight DiffAdd guifg=#50a14f ctermfg=22") -- 추가된 부분의 색상
-- vim.cmd("highlight DiffChange guifg=#7070f0 ctermfg=94") -- 변경된 부분의 색상
-- vim.cmd("highlight DiffDelete guifg=#d75f5f ctermfg=196") -- 삭제된 부분의 색상
-- vim.cmd("highlight DiffText guifg=#f0c05a ctermfg=220") -- 변경된 부분의 색상
