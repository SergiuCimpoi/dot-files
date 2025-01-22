return {
  "lmantw/themify.nvim",
  lazy = false,
  priority = 999,

  config = function()
    require("themify").setup({
      {
        "folke/tokyonight.nvim",
        before = function()
          vim.cmd("highlight LineNr guifg=#5D6885 gui=bold")
          require("tokyonight").setup({
            on_colors = function(colors)
              -- colors.fg_gutter = "#4C5573"
            end,
            on_highlights = function(highlights, colors)
              highlights.LineNr = {
                fg = "#6e7bb7",
              }
              highlights.LineNrAbove = {
                fg = "#6e7bb7",
              }
              highlights.LineNrBelow = {
                fg = "#6e7bb7",
              }
            end,
          })
        end,
      },
      "Yazeed1s/minimal.nvim",
      "catppuccin/nvim",
      {
        "sho-87/kanagawa-paper.nvim",

        branch = "master",
      },

      -- Built-in colorschemes are also supported.
      -- (Also works with any colorschemes that are installed via other plugin manager, just make sure the colorscheme is loaded before Themify is loaded.)
      "default",
    })
  end,
}
