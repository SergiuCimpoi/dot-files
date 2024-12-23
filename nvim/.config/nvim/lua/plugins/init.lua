return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
  -- "tpope/vim-obsession",
}
