return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      backdrop = 0.95, -- dim the background slightly
      width = 0.8, -- use % of screen width
      height = 1, -- full height
      options = {
        signcolumn = "no", -- hide signcolumn
        number = true, -- hide absolute line numbers
        relativenumber = true, -- hide relative line numbers
        cursorline = true, -- hide cursorline
        cursorcolumn = false, -- hide cursorcolumn
        foldcolumn = "0", -- hide foldcolumn
        list = false, -- disable whitespace characters
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false, -- hide the ruler in the command line area
        showcmd = false, -- hide (partial) command in the last line of the screen
      },
      tmux = { enabled = true }, -- hide tmux statusline (requires allow-passthrough)
    },
    on_open = function()
      -- Hide bufferline and dropbar (if used)
      vim.opt.showtabline = 0
      pcall(function()
        local dropbar = require("dropbar")
        if dropbar and dropbar.refresh then
          vim.wo.winbar = nil
          dropbar.refresh()
        end
      end)
    end,
    on_close = function()
      -- Restore bufferline and dropbar
      vim.opt.showtabline = 2
      pcall(function()
        local dropbar = require("dropbar")
        if dropbar and dropbar.refresh then
          dropbar.refresh()
        end
      end)
    end,
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
}
