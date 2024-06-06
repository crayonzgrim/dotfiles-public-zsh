return {
  "David-Kunz/gen.nvim",
  -- cmd = "Gen",
  config = function()
    local gen = require("gen")

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
}
