return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth",
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
          "Folded",
          "TabLineFill",
          "BufferLineFill",
          "BufferLineOffsetSeparator",
          "BufferLineIndicatorVisible",
          "BufferLineSerparatorVisible",
        },
        extra_groups = {
          "NeoTreeNormal",
          "NeoTreeFloatNormal",
          "NeoTreeNormalNC",
        },
        exclude_groups = {},
      })
    end,
  },
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
  "tidalcycles/vim-tidal",
}
