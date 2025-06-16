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
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   enabled = vim.g.neovim_mode ~= "skitty", -- Disable plugin for skitty mode
  --   cond = vim.g.neovide == nil,
  --   opts = {
  --     stiffness = 0.8, -- 0.6      [0, 1]
  --     trailing_stiffness = 0.4, -- 0.4      [0, 1]
  --     stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
  --     trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
  --     distance_stop_animating = 0.5, -- 0.1      > 0
  --   },
  -- },
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "saecki/live-rename.nvim",
    keys = {
      {
        "cr",
        function()
          require("live-rename").rename()
        end,
        desc = "Rename",
      },
      {
        "cR",
        function()
          require("live-rename").rename({ text = "", insert = true })
        end,
        desc = "Rename (replace)",
      },
    },
    opts = {
      hl = {
        current = "LiveRenameCurrent",
        others = "LiveRenameOther",
      },
    },
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
}
