return {
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
    "yetone/avante.nvim",
    enabled = true,
    build = "make",
    event = "VeryLazy",
    version = false,
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
        config = function(_, opts)
          require("render-markdown").setup(opts)
        end,
      },
    },
  },
}
