return {
  "dustinblackman/oatmeal.nvim",
  cmd = { "Oatmeal" },
  keys = {
    { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
  },
  opts = {
    backend = "ollama",
    -- model = "hkjang/llama3-ko:latest",
    -- model = "llama3:latest",
    model = "gemma:latest",
    -- model = "codellama:latest",
  },
}
