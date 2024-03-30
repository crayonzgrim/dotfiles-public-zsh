return {
  "David-Kunz/gen.nvim",
  -- cmd = "Gen",
  config = function()
    local gen = require("gen")

    gen.setup({
      model = "codellama", -- The default model to use.
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
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
