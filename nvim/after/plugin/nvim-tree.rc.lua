local status, nvim_tree = pcall(require, "nvim-tree")
if not status then return end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    }
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
