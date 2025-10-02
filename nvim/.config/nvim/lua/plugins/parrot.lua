return {
  "frankroeder/parrot.nvim",
  dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
  -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
  config = function()
    require("parrot").setup({
      default_provider = "openai",
      providers = {
        -- anthropic = {
        --   api_key = os.getenv("ANTHROPIC_API_KEY"),
        -- },
        -- gemini = {
        --   api_key = os.getenv("GEMINI_API_KEY"),
        -- },
        -- groq = {
        --   api_key = os.getenv("GROQ_API_KEY"),
        -- },
        -- mistral = {
        --   api_key = os.getenv("MISTRAL_API_KEY"),
        -- },
        -- pplx = {
        --   api_key = os.getenv("PERPLEXITY_API_KEY"),
        -- },
        -- ollama = {},
        openai = {
          name = "openai",
          api_key = os.getenv("OPENAI_API_KEY"),

          endpoint = "https://api.openai.com/v1/chat/completions",
          params = {
            chat = { temperature = 1.1, top_p = 1 },

            command = { temperature = 1.1, top_p = 1 },
          },

          topic = {
            model = "gpt-4.1-nano",
            params = { max_completion_tokens = 64 },
          },
          models = {
            "gpt-4o",
            "o4-mini",

            "gpt-4.1-nano",
          },
        },
        -- github = {
        --   api_key = os.getenv("GITHUB_TOKEN"),
        -- },
        -- nvidia = {
        --   api_key = os.getenv("NVIDIA_API_KEY"),
        -- },
        -- xai = {
        --   api_key = os.getenv("XAI_API_KEY"),
        -- },
      },
    })
  end,
}
