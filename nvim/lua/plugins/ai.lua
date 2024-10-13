return {
  {
    "David-Kunz/gen.nvim",
    -- cmd = "Gen",
    config = function()
      local gen = require("gen")

      gen.prompts["Web develop me!"] = {
        prompt = "You are a senior Web developer(especially master of frontend), acting as an assistant. You offer help with web develop technologies like: NextJS, React, javascript, typescript, NestJS, HTML, CSS, expressJS and so on. You answer with code examples when possible. $input:\n$text",
        replace = false,
      }

      gen.setup({
        -- model = "dolphin-llama3:latest",
        -- model = "hkjang/llama3-ko:latest",
        -- model = "llama3:latest", -- The default model to use.
        model = "gemma:latest", -- The default model to use.
        -- model = "codellama", -- The default model to use.
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
  },
  {
    "dustinblackman/oatmeal.nvim",
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
      -- model = "llama3:latest",
      model = "gemma:latest",
      -- model = "codellama:latest",
    },
  },
}
