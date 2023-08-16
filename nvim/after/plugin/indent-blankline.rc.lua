local status, indent = pcall(require, "indent_blankline")
if not status then
	return
end

vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#3B3B3B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#3B3B3B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#3B3B3B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#3B3B3B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#3B3B3B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#3B3B3B gui=nocombine]])

--  vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

vim.opt.list = true

indent.setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = false,
	-- char_highlight_list = {
	-- 	"IndentBlanklineIndent1",
	-- 	"IndentBlanklineIndent2",
	-- 	"IndentBlanklineIndent3",
	-- 	"IndentBlanklineIndent4",
	-- 	"IndentBlanklineIndent5",
	-- 	"IndentBlanklineIndent6",
	-- },
})
