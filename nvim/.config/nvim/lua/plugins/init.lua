return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },
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
        }, -- additional groups that should be cleared
        exclude_groups = {}, -- groups you don't want to clear
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        autojump = true,
        pos = "start",
      },
      modes = {
        char = {
          jump_labels = true,
          multi_line = false,
        },
        search = {
          mode = "search",
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n" },           function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled = vim.g.neovim_mode ~= "skitty", -- Disable plugin for skitty mode
    cond = vim.g.neovide == nil,
    opts = {
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.4, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
    },
    {
      "HiPhish/rainbow-delimiters.nvim",
      enabled = false,
    },
  },
}
