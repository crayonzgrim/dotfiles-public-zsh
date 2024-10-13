return {
  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>nc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>cr",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "rename",
      }
    end,
    config = function()
      vim.keymap.set("n", "<leader>rn", ":IncRename ")

      require("inc_rename").setup({})
    end,
  },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

  -- Go forward/backward with square brackets
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
        file = { suffix = "" },
        window = { suffix = "" },
        quickfix = { suffix = "" },
        yank = { suffix = "" },
        treesitter = { suffix = "n" },
      })
    end,
  },

  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        close = "q",
        -- Use this if you want to open several files
        go_in = "l",
        -- This opens the file, but quits out of mini.files (default L)
        go_in_plus = "<CR>",
        -- I swapped the following 2 (default go_out: h)
        -- go_out_plus: when you go out, it shows you only 1 item to the right
        -- go_out: shows you all the items to the right
        go_out = "H",
        go_out_plus = "h",
        -- Default <BS>
        reset = ",",
        -- Default @
        reveal_cwd = ".",
        show_help = "g?",
        -- Default =
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 90,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
        -- If set to false, files are moved to the trash directory
        -- To get this dir run :echo stdpath('data')
        -- ~/.local/share/neobean/mini.files/trash
        permanent_delete = false,
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_target_window()
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = close_on_file })
          end
        end

        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.toggle_hidden or "g.",
            toggle_dotfiles,
            { buffer = buf_id, desc = "Toggle hidden files" }
          )

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.change_cwd or "gc",
            files_set_cwd,
            { buffer = args.data.buf_id, desc = "Set cwd" }
          )

          map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          LazyVim.lsp.on_rename(event.data.from, event.data.to)
        end,
      })

      ---------------------------------------------------------------------------
      ---------------------------------------------------------------------------

      -- -- All of the section below is to show the git status on files found here
      -- -- https://www.reddit.com/r/neovim/comments/1c37m7c/is_there_a_way_to_get_the_minifiles_plugin_to/
      -- -- Which points to
      -- -- https://gist.github.com/bassamsdata/eec0a3065152226581f8d4244cce9051#file-notes-md
      local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
      local autocmd = vim.api.nvim_create_autocmd
      local _, MiniFiles = pcall(require, "mini.files")

      -- Cache for git status
      local gitStatusCache = {}
      local cacheTimeout = 2000 -- Cache timeout in milliseconds

      local function mapSymbols(status)
        local statusMap = {
        -- stylua: ignore start 
        [" M"] = { symbol = "✹", hlGroup  = "MiniDiffSignChange"}, -- Modified in the working directory
        ["M "] = { symbol = "•", hlGroup  = "MiniDiffSignChange"}, -- modified in index
        ["MM"] = { symbol = "≠", hlGroup  = "MiniDiffSignChange"}, -- modified in both working tree and index
        ["A "] = { symbol = "+", hlGroup  = "MiniDiffSignAdd"   }, -- Added to the staging area, new file
        ["AA"] = { symbol = "≈", hlGroup  = "MiniDiffSignAdd"   }, -- file is added in both working tree and index
        ["D "] = { symbol = "-", hlGroup  = "MiniDiffSignDelete"}, -- Deleted from the staging area
        ["AM"] = { symbol = "⊕", hlGroup  = "MiniDiffSignChange"}, -- added in working tree, modified in index
        ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange"}, -- Added in the index and deleted in the working directory
        ["R "] = { symbol = "→", hlGroup  = "MiniDiffSignChange"}, -- Renamed in the index
        ["U "] = { symbol = "‖", hlGroup  = "MiniDiffSignChange"}, -- Unmerged path
        ["UU"] = { symbol = "⇄", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged
        ["UA"] = { symbol = "⊕", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged and added in working tree
        ["??"] = { symbol = "?", hlGroup  = "MiniDiffSignDelete"}, -- Untracked files
        ["!!"] = { symbol = "!", hlGroup  = "MiniDiffSignChange"}, -- Ignored files
          -- stylua: ignore end
        }

        local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
        return result.symbol, result.hlGroup
      end

      ---@param cwd string
      ---@param callback function
      local function fetchGitStatus(cwd, callback)
        local function on_exit(content)
          if content.code == 0 then
            callback(content.stdout)
            vim.g.content = content.stdout
          end
        end
        vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = cwd }, on_exit)
      end

      local function escapePattern(str)
        return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
      end

      local function updateMiniWithGit(buf_id, gitStatusMap)
        vim.schedule(function()
          local nlines = vim.api.nvim_buf_line_count(buf_id)
          local cwd = vim.fn.getcwd() --  vim.fn.expand("%:p:h")
          local escapedcwd = escapePattern(cwd)
          if vim.fn.has("win32") == 1 then
            escapedcwd = escapedcwd:gsub("\\", "/")
          end

          for i = 1, nlines do
            local entry = MiniFiles.get_fs_entry(buf_id, i)
            if not entry then
              break
            end
            local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
            local status = gitStatusMap[relativePath]

            if status then
              local symbol, hlGroup = mapSymbols(status)
              vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
                -- NOTE: if you want the signs on the right uncomment those and comment
                -- the 3 lines after
                -- virt_text = { { symbol, hlGroup } },
                -- virt_text_pos = "right_align",
                sign_text = symbol,
                sign_hl_group = hlGroup,
                priority = 2,
              })
            else
            end
          end
        end)
      end

      local function is_valid_git_repo()
        if vim.fn.isdirectory(".git") == 0 then
          return false
        end
        return true
      end

      -- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
      local function parseGitStatus(content)
        local gitStatusMap = {}
        -- lua match is faster than vim.split (in my experience )
        for line in content:gmatch("[^\r\n]+") do
          local status, filePath = string.match(line, "^(..)%s+(.*)")
          -- Split the file path into parts
          local parts = {}
          for part in filePath:gmatch("[^/]+") do
            table.insert(parts, part)
          end
          -- Start with the root directory
          local currentKey = ""
          for i, part in ipairs(parts) do
            if i > 1 then
              -- Concatenate parts with a separator to create a unique key
              currentKey = currentKey .. "/" .. part
            else
              currentKey = part
            end
            -- If it's the last part, it's a file, so add it with its status
            if i == #parts then
              gitStatusMap[currentKey] = status
            else
              -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
              if not gitStatusMap[currentKey] then
                gitStatusMap[currentKey] = status
              end
            end
          end
        end
        return gitStatusMap
      end

      local function updateGitStatus(buf_id)
        if not is_valid_git_repo() then
          return
        end
        local cwd = vim.fn.expand("%:p:h")
        local currentTime = os.time()
        if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
          updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
        else
          fetchGitStatus(cwd, function(content)
            local gitStatusMap = parseGitStatus(content)
            gitStatusCache[cwd] = {
              time = currentTime,
              statusMap = gitStatusMap,
            }
            updateMiniWithGit(buf_id, gitStatusMap)
          end)
        end
      end

      local function clearCache()
        gitStatusCache = {}
      end

      local function augroup(name)
        return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
      end

      autocmd("User", {
        group = augroup("start"),
        pattern = "MiniFilesExplorerOpen",
        -- pattern = { "minifiles" },
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          updateGitStatus(bufnr)
        end,
      })

      autocmd("User", {
        group = augroup("close"),
        pattern = "MiniFilesExplorerClose",
        callback = function()
          clearCache()
        end,
      })

      autocmd("User", {
        group = augroup("update"),
        pattern = "MiniFilesBufferUpdate",
        callback = function(sii)
          local bufnr = sii.data.buf_id
          local cwd = vim.fn.expand("%:p:h")
          if gitStatusCache[cwd] then
            updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
          end
        end,
      })
    end,
  },

  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },

  {
    -- "nvim-cmp",
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "L3MON4D3/LuaSnip", -- Snippet Engine & its associated nvim-cmp source
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "rafamadriz/friendly-snippets", -- Adds a number of user-friendly snippets
      "onsails/lspkind.nvim", -- Adds vscode-like pictograms

      -- codeium
      "Exafunction/codeium.vim",
      -- "Exafunction/codeium.nvim",
      "monkoose/neocodeium",

      -- tabnine
      "tzachar/cmp-tabnine",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.config.formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter,
      }

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
          { name = "calc" },
          { name = "emoji" },
          { name = "treesitter" },
          { name = "crates" },
          { name = "tmux" },
          { name = "neocodeium" },
        }),

        experimental = {
          ghost_text = true,
        },
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, 1, {
        name = "neocodeium",
        group_index = 1,
        priority = 100,
      })
      table.insert(opts.sources, 1, {
        name = "cmp_tabnine",
        group_index = 1,
        priority = 100,
      })

      opts.formatting.format = LazyVim.inject.args(opts.formatting.format, function(entry, item)
        -- Hide percentage in the menu
        if entry.source.name == "cmp_tabnine" then
          item.menu = ""
        end
      end)
    end,
  },
}
