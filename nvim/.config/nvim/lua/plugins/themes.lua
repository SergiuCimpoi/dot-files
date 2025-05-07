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
            on_highlights = function(highlights, colors)
              highlights.LineNr = {
                fg = "#5d689a",
              }
              highlights.LineNrAbove = {
                fg = "#5d689a",
              }
              highlights.LineNrBelow = {
                fg = "#5d689a",
              }
            end,
          })
        end,
      },
      "catppuccin/nvim",
      "rebelot/kanagawa.nvim",
      "rose-pine/neovim",
      "EdenEast/nightfox.nvim",
      "olimorris/onedarkpro.nvim",
      "sainnhe/gruvbox-material",
      "sainnhe/everforest",
      "Mofiqul/dracula.nvim",
      "marko-cerovac/material.nvim",
      "craftzdog/solarized-osaka.nvim",
      "AlexvZyl/nordic.nvim",
      "scottmckendry/cyberdream.nvim",
      "ribru17/bamboo.nvim",
      "bluz71/vim-moonfly-colors",
      "sainnhe/sonokai",
      "eldritch-theme/eldritch.nvim",
      after_colorscheme = function()
        -- Define pale rainbow highlight groups
        vim.api.nvim_set_hl(0, "SnacksIndent1", { bg = "#a6cee3" })
        vim.api.nvim_set_hl(0, "SnacksIndent2", { bg = "#b2df8a" })
        vim.api.nvim_set_hl(0, "SnacksIndent3", { bg = "#fb9a99" })
        vim.api.nvim_set_hl(0, "SnacksIndent4", { bg = "#fdbf6f" })
        vim.api.nvim_set_hl(0, "SnacksIndent5", { bg = "#cab2d6" })
        vim.api.nvim_set_hl(0, "SnacksIndent6", { bg = "#ffff99" })
        vim.api.nvim_set_hl(0, "SnacksIndent7", { bg = "#1f78b4" })
        vim.api.nvim_set_hl(0, "SnacksIndent8", { bg = "#33a02c" })
      end,
    })
  end,
}
