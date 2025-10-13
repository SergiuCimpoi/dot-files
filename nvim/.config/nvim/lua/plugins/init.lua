return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth",
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "xzbdmw/clasp.nvim",
    keys = {
      {
        "<M-t>",
        function()
          require("clasp").wrap("next")
        end,
        mode = { "i", "n" },
        desc = "Wrap next treesitter node with paranthesis",
      },
      {
        "<M-T>",
        function()
          require("clasp").wrap("prev")
        end,
        mode = { "i", "n" },
        desc = "Wrap previous treesitter node with paranthesis",
      },
    },
    opts = {},
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
}
