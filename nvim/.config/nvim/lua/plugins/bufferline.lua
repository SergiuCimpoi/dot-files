return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "moll/vim-bbye",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "ordinal",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "BufferLineOffset",
            text_align = "left",
          },
        },
      },
      highlights = {
        fill = { bg = "none" },
        background = { bg = "none" },
        buffer_visible = { bg = "none" },
        close_button = { bg = "none" },
        separator = { bg = "none" },

        -- buffer_selected = { bg = "#2B2C2E", fg = "#89B3FB", bold = true },
        -- numbers_selected = { bg = "#2B2C2E", fg = "#89B3FB" },
        -- close_button_selected = { bg = "#2B2C2E", fg = "#89B3FB" },
        -- separator_selected = { bg = "#2B2C2E" },
        -- indicator_selected = { bg = "#2B2C2E" },

        buffer_selected = { bg = "none", fg = "#89B3FB", bold = true },
        numbers_selected = { bg = "none", fg = "#89B3FB" },
        close_button_selected = { bg = "none", fg = "#89B3FB" },
        separator_selected = { bg = "none" },
        indicator_selected = { bg = "none" },

        numbers = { bg = "none" },
        numbers_visible = { bg = "none" },
      },
    })
  end,
}
