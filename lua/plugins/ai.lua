return {
  {
    "augmentcode/augment.vim",
    event = "VeryLazy", -- or use 'BufRead' for faster loading
    cmd = { "Augment" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },

    config = function()
      vim.keymap.set("n", "\\ac", ":Augment chat<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "\\an", ":Augment chat-new<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "\\at", ":Augment chat-toggle<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "\\al", ":Augment log<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>ac", ":Augment chat<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>an", ":Augment chat-new<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>at", ":Augment chat-toggle<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>al", ":Augment log<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    event = "InsertEnter",
    cmd = {
      "SupermavenUseFree",
      "SupermavenUsePro",
    },
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
      },
      disable_inline_completion = vim.g.ai_cmp,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    },
  },

  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<c-g>", neocodeium.accept)
    end,
  },

  {
    "David-Kunz/gen.nvim",
    enabled = false,
    cmd = "Gen",
    config = function()
      local gen = require("gen")

      gen.prompts["Web develop me!"] = {
        prompt = "You are a senior Web developer(especially master of frontend), acting as an assistant. You offer help with web develop technologies like: NextJS, React, javascript, typescript, NestJS, HTML, CSS, expressJS and so on. You answer with code examples when possible. $input:\n$text",
        replace = false,
      }

      gen.setup({
        -- model = "deepseek-r1:latest:latest",
        -- model = "deepseek-r1:latest",
        -- model = "llama3:latest", -- The default model to use.
        -- model = "gemma:latest", -- The default model to use.
        model = "codellama:latest", -- The default model to use.
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = true, -- Shows the Prompt submitted to Ollama.
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = true, -- Never closes the window automatically.
        quit_map = "q", -- set keymap for quit
      })
      gen.prompts["Fix_Code"] = {
        prompt = "Fix the following code as a senior web developer. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```",
      }
    end,
    opts = {
      model = "codellama:latest", -- The default model to use.
      quit_map = "q", -- set keymap to close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
      host = "localhost", -- The host running the Ollama service.
      port = "11434", -- The port on which the Ollama service is listening.
      display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      file = false, -- Write the payload to a temporary file to keep the command short.
      hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      result_filetype = "markdown", -- Configure filetype of the result buffer
      debug = false, -- Prints errors and the command which is run.
    },
  },
  {
    "dustinblackman/oatmeal.nvim",
    enabled = false,
    cmd = { "Oatmeal" },
    keys = {
      { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
      { "<leader>ol", mode = "n", desc = "open Oatmeal session" },
      { "<leader>op", mode = "n", desc = "Pick Oatmeal prompt" },
      { "<leader>on", mode = "n", desc = "End Oatmeal session" },
      -- HOTKEYS:
      -- - Up arrow - Scroll up.
      -- - Down arrow - Scroll down.
      -- - CTRL+U - Page up.
      -- - CTRL+D - Page down.
      -- - CTRL+C - Interrupt waiting for prompt response if in progress, otherwise exit.
      -- - CTRL+O - Insert a line break at the cursor position.
      -- - CTRL+R - Resubmit your last message to the backend.
    },
    opts = {
      backend = "ollama",
      -- model = "hkjang/llama3-ko:latest",
      model = "codellama:latest",
      -- model = "gemma:latest",
      -- model = "codellama:latest",
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = true,
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = "#ffffff",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
        condition = function()
          return false
        end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "codellama",
          inline = "codellama",
          -- adapter = "qwen",
          -- inline = "qwen",
        },
      },
      adapters = {
        qwen = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen", -- 이 어댑터를 기본 ollama 어댑터와 구별하기 위해 다른 이름을 지정
            schema = {
              model = {
                default = "codellama:latest",
                -- default = "qwen2.5-coder:latest",
              },
            },
          })
        end,
      },
      opts = {
        log_level = "DEBUG",
      },
    },
  },

  -- @codebase 전체 코드베이스 컨텍스트를 포함합니다. ex) @codebase explain the project structure- 전체 코드베이스를 살펴봅니다.
  -- @diagnostics 현재 진단 문제 포함  ex) @diagnostics how do I fix these errors?- 진단 문제 해결에 도움이 됩니다.
  -- @file 현재 파일 포함 ex) @file what are the issues in this code?- 현재 파일을 분석합니다
  -- @quickfix 빠른 수정 목록 포함
  -- @buffers 모든 열린 버퍼를 포함합니다
  {
    "yetone/avante.nvim",
    enabled = true,
    build = "make",
    event = "VeryLazy",
    version = false,
    -- keys = {
    --   {
    --     "<leader>aa",
    --     function()
    --       vim.cmd("AvanteAsk position=right ")
    --     end,
    --     desc = "Avante: Ask AI",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ac",
    --     function()
    --       vim.cmd("AvanteChat")
    --     end,
    --     desc = "Avante: Chat with AI",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>an",
    --     function()
    --       vim.cmd("AvanteChatNew")
    --     end,
    --     desc = "Avante: New Chat Session",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ah",
    --     function()
    --       vim.cmd("AvanteHistory")
    --     end,
    --     desc = "Avante: Chat History",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ax",
    --     function()
    --       vim.cmd("AvanteClear")
    --     end,
    --     desc = "Avante: Clear Chat History",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ae",
    --     function()
    --       vim.cmd("AvanteEdit")
    --     end,
    --     desc = "Avante: Edit Code Blocks",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>af",
    --     function()
    --       vim.cmd("AvanteFocus")
    --     end,
    --     desc = "Avante: Focus Sidebar",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ar",
    --     function()
    --       vim.cmd("AvanteRefresh")
    --     end,
    --     desc = "Avante: Refresh Avante",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>as",
    --     function()
    --       vim.cmd("AvanteStop")
    --     end,
    --     desc = "Avante: Stop AI Request",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>at",
    --     function()
    --       vim.cmd("AvanteToggle")
    --     end,
    --     desc = "Avante: Toggle Sidebar",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ap",
    --     function()
    --       vim.cmd("AvanteSwitchProvider")
    --     end,
    --     desc = "Avante: Switch Provider",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>am",
    --     function()
    --       vim.cmd("AvanteModels")
    --     end,
    --     desc = "Avante: Show Model List",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>amap",
    --     function()
    --       vim.cmd("AvanteShowRepoMap")
    --     end,
    --     desc = "Avante: Show Repo Map",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ase",
    --     function()
    --       vim.cmd("AvanteSwitchSelectorProvider")
    --     end,
    --     desc = "Avante: Switch Selector Provider",
    --     mode = "n",
    --   },
    --   {
    --     "<leader>ab",
    --     function()
    --       vim.cmd("AvanteBuild")
    --     end,
    --     desc = "Avante: Build Project",
    --     mode = "n",
    --   },
    -- },
    opts = {
      -- 이하 기존 설정 유지
      provider = "claude",
      mode = "agentic",
      auto_suggestions_provider = "claude",
      default_prompt = {
        system = [[
You are a helpful AI assistant.
Respond in Markdown format.
Include comments in code if helpful.
If the user uses Korean, reply in Korean.
]],
        context = "",
      },
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = true,
        auto_approve_tool_permissions = false,
      },
      prompt_logger = {
        enabled = true,
        log_dir = vim.fn.stdpath("cache") .. "/avante_prompts",
        fortune_cookie_on_success = false,
        next_prompt = {
          normal = "<C-n>",
          insert = "<C-n>",
        },
        prev_prompt = {
          normal = "<C-p>",
          insert = "<C-p>",
        },
      },
      selector = {
        exclude_auto_select = { "NvimTree" },
      },
      rag_service = {
        enabled = false,
        host_mount = "/Users/dongilkim",
        runner = "docker",
        llm = {
          provider = "ollama",
          endpoint = "http://localhost:11434",
          api_key = "",
          model = "codellama:latest",
        },
        embed = {
          provider = "ollama",
          endpoint = "http://localhost:11434",
          api_key = "",
          model = "nomic-embed-text:latest",
          extra = nil,
        },
        docker_extra_args = "--platform linux/amd64",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        enabled = false,
        event = "VeryLazy",
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
      -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oo",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama prompt",
        mode = { "n", "v" },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>oG",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "ollama Generate Code",
        mode = { "n", "v" },
      },
    },

    ---@type Ollama.Config
    opts = {
      model = "gemma3:1b",
      url = "http://127.0.0.1:11434",
      -- View the actual default prompts in ./lua/ollama/prompts.lua
      prompts = {
        Sample_Prompt = {
          prompt = "You are a helpful AI assistant. Respond in Markdown format. Include comments in code if helpful. If the user uses Korean, reply in Korean.",
          input_label = "> ",
          model = "mistral",
          action = "display",
        },
      },
    },
  },
}
