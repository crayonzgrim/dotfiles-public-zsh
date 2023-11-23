return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  -- animations
  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     opts.scroll = {
  --       enable = false,
  --     }
  --   end,
  -- },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "}", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "{", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "solarized_dark",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
 ██████╗██████╗  █████╗ ██╗   ██╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██████╗ ██╗███╗   ███╗
██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝██╔═══██╗████╗  ██║╚══███╔╝██╔════╝ ██╔══██╗██║████╗ ████║
██║     ██████╔╝███████║ ╚████╔╝ ██║   ██║██╔██╗ ██║  ███╔╝ ██║  ███╗██████╔╝██║██╔████╔██║
██║     ██╔══██╗██╔══██║  ╚██╔╝  ██║   ██║██║╚██╗██║ ███╔╝  ██║   ██║██╔══██╗██║██║╚██╔╝██║
╚██████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║ ╚████║███████╗╚██████╔╝██║  ██║██║██║ ╚═╝ ██║
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua", -- showex color
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
          html = { names = false }, -- Disable parsing "names" like Blue or Gray
        },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode. "foreground" / "background" / "virtualtext"
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },
  {
    "ap/vim-css-color",
  },
  {
    "anuvyklack/hydra.nvim",
    config = function()
      local Hydra = require("hydra")
      local cmd = require("hydra.keymap-util").cmd

      Hydra({
        name = "Resize Window",
        mode = { "n" },
        body = "<C-w>",
        config = {
          -- color = "pink",
        },
        heads = {
          -- resizing window
          { "H", "<C-w>2<", { noremap = true } },
          { "L", "<C-w>2>", { noremap = true } },
          { "K", "<C-w>2+", { noremap = true } },
          { "J", "<C-w>2-", { noremap = true } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })

      Hydra({
        name = "Side scroll",
        mode = "n",
        body = "z",
        heads = {
          { "h", "5zh" },
          { "l", "5zl", { desc = "←/→" } },
          { "H", "zH" },
          { "L", "zL", { desc = "half screen ←/→" } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })

      local telescopeHint = [[
 _f_: files       _m_: marks
 _o_: old files   _g_: live grep
 _p_: projects    _/_: search in file

 _r_: resume      _u_: undotree
 _h_: vim help    _c_: execute command
 _k_: keymaps     _;_: commands history
 _O_: options     _?_: search history
]]

      Hydra({
        name = "Telescope",
        hint = telescopeHint,
        config = {
          color = "teal",
          invoke_on_body = true,
          hint = {
            position = "middle",
            border = "rounded",
          },
        },
        mode = "n",
        body = "\\f",
        heads = {
          { "f", cmd("Telescope find_files") },
          { "g", cmd("Telescope live_grep") },
          { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
          { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
          { "m", cmd("MarksListBuf"), { desc = "marks" } },
          { "k", cmd("Telescope keymaps") },
          { "O", cmd("Telescope vim_options") },
          { "r", cmd("Telescope resume") },
          { "p", cmd("Telescope projects"), { desc = "projects" } },
          { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
          { "?", cmd("Telescope search_history"), { desc = "search history" } },
          { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
          { "c", cmd("Telescope commands"), { desc = "execute command" } },
          { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
          -- { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },

          -- exit this Hydra
          { "q", nil, { exit = true, nowait = true } },
          { "<Esc>", nil, { exit = true, nowait = true } },
        },
      })
    end,
  },
  {
    "ziontee113/color-picker.nvim",
    enable = true,
    config = function()
      local picker = require("color-picker")

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
      vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

      picker.setup({
        -- for changing icons & mappings
        ["icons"] = { "", "🎨" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "ﱢ", "" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = { -- mapping example:
          ["U"] = "<Plug>ColorPickerSlider5Decrease",
          ["O"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal", -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal", --default
      })

      vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
    end,
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "rmagatti/goto-preview", -- preview
    config = function()
      local preview = require("goto-preview")

      preview.setup({
        width = 130, -- Width of the floating window
        height = 20, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      })

      vim.api.nvim_set_keymap(
        "n",
        "gp",
        "<Cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { noremap = true }
      )
      vim.api.nvim_set_keymap("n", "gq", "<Cmd>q<CR>", { noremap = true })
    end,
  },
}
