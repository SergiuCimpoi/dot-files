return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- add more filetypes if you want
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons", -- or "nvim-tree/nvim-web-devicons"
  },
  opts = {
    -- minimal; defaults are good
    enabled = true,
    file_types = { "markdown" },
  },
  keys = {
    {
      "<leader>md",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle Markdown render",
    },
  },
}
