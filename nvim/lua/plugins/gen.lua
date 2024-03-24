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

-- return {
--   "David-Kunz/gen.nvim",
--   opts = {
--     model = "llama2", -- The default model to use("mistral, codellama, llama2").
--     host = "localhost", -- The host running the Ollama service.
--     port = "11434", -- The port on which the Ollama service is listening.
--     display_mode = "float", -- The display mode. Can be "float" or "split".
--     show_prompt = false, -- Shows the Prompt submitted to Ollama.
--     show_model = true, -- Displays which model you are using at the beginning of your chat session.
--     quit_map = "q", -- set keymap for quit
--     no_auto_close = true, -- Never closes the window automatically.
--     init = function(options)
--       pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
--     end,
--     -- Function to initialize Ollama
--     command = function(options)
--       return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
--     end,
--     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
--     -- This can also be a command string.
--     -- The executed command must return a JSON object with { response, context }
--     -- (context property is optional).
--     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
--     debug = false, -- Prints errors and the command which is run.
--   },
-- }
