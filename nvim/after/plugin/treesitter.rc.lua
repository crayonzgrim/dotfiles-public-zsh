local status, tree = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

tree.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "markdown",
        "tsx",
        "toml",
        "fish",
        "python",
        "php",
        "json",
        "yaml",
        "swift",
        "css",
        "html",
        "lua"
    },
    autotag = {
        enable = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "javascript.jsx", "typescript", "typescript.tsx" }
