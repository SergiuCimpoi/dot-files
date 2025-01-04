return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
  "ThePrimeagen/vim-be-good",
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        groups = { -- default groups to clear
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
          "CursorLine",
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
          "NeoTreeNormalNC",
        }, -- additional groups that should be cleared
        exclude_groups = {}, -- groups you don't want to clear
      })
    end,
  },
}
