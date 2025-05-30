return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Ensure it loads before other plugins that use highlights
  lazy = false, -- Load at startup for consistent colors
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      -- color_overrides = {
      --   mocha = {
      --     text = "#FF0000", -- Your custom main text color
      --   },
      -- },
      highlight_overrides = {
        mocha = function(mocha)
          return {
            LineNr = { fg = mocha.overlay1 },
            CursorLineNr = { fg = mocha.maroon, bold = true },
          }
        end,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        dap = true,
        dap_ui = true,
        fzf = true,
        flash = true,
        neotree = true,
        noice = true,
        mason = true,
        snacks = true,
        which_key = true,
        treesitter_context = true,
        -- Add or remove integrations as you use them
      },
      -- Optional: Other Catppuccin options
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      no_italic = false,
      no_bold = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
