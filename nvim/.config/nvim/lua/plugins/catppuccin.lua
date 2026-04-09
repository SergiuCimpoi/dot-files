return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,

      custom_highlights = function(C)
        return {
          -- Core editor
          LineNr = { fg = C.overlay1 },
          CursorLineNr = { fg = C.maroon, bold = true },

          -- -- C++ readability: cool down the warm palette
          ["@type"] = { fg = C.blue },
          ["@type.builtin"] = { fg = C.sapphire },
          ["@type.definition"] = { fg = C.blue, style = { "bold" } },

          ["@constructor"] = { fg = C.blue, style = { "bold" } },
          ["@namespace"] = { fg = C.mauve },
          ["@module"] = { fg = C.lavender },

          ["@keyword"] = { fg = C.mauve },
          ["@keyword.function"] = { fg = C.mauve },
          ["@keyword.operator"] = { fg = C.mauve },
          ["@keyword.return"] = { fg = C.red, style = { "italic" } },
          --
          -- ["@operator"] = { fg = C.sky },
          -- ["@punctuation.bracket"] = { fg = C.overlay2 },
          -- ["@punctuation.delimiter"] = { fg = C.overlay2 },
          -- ["@punctuation.special"] = { fg = C.sky },
          --
          -- ["@function"] = { fg = C.green },
          -- ["@function.call"] = { fg = C.green },
          -- ["@function.method"] = { fg = C.teal },
          -- ["@function.method.call"] = { fg = C.teal },
          --
          -- ["@parameter"] = { fg = C.flamingo, style = { "italic" } },
          -- ["@parameter.reference"] = { fg = C.flamingo },
          --
          -- ["@variable"] = { fg = C.lavender },
          -- ["@variable.builtin"] = { fg = C.red, style = { "italic" } },
          -- ["@variable.member"] = { fg = C.rosewater },
          -- ["@property"] = { fg = C.rosewater },
          --
          -- ["@field"] = { fg = C.rosewater },
          -- ["@constant"] = { fg = C.peach },
          -- ["@constant.builtin"] = { fg = C.red },
          -- ["@constant.macro"] = { fg = C.red, style = { "bold" } },
          --
          -- ["@string"] = { fg = C.green },
          -- ["@string.escape"] = { fg = C.pink },
          -- ["@number"] = { fg = C.peach },
          -- ["@boolean"] = { fg = C.peach },
          --
          -- ["@comment"] = { fg = C.overlay1, style = { "italic" } },
          --
          -- ["@preproc"] = { fg = C.red },
          -- ["@include"] = { fg = C.mauve },
          -- ["@attribute"] = { fg = C.yellow },
          --
          -- ["@label"] = { fg = C.sapphire },
          --
          -- -- LSP semantic token fallbacks
          -- ["@lsp.type.namespace"] = { link = "@namespace" },
          -- ["@lsp.type.type"] = { link = "@type" },
          -- ["@lsp.type.class"] = { link = "@type" },
          -- ["@lsp.type.struct"] = { link = "@type" },
          -- ["@lsp.type.enum"] = { link = "@type" },
          -- ["@lsp.type.enumMember"] = { fg = C.peach },
          -- ["@lsp.type.typeParameter"] = { fg = C.yellow, style = { "italic" } },
          --
          -- ["@lsp.type.function"] = { link = "@function" },
          -- ["@lsp.type.method"] = { link = "@function.method" },
          --
          -- ["@lsp.type.parameter"] = { link = "@parameter" },
          -- ["@lsp.type.property"] = { link = "@property" },
          -- ["@lsp.type.variable"] = { link = "@variable" },
          --
          -- ["@lsp.mod.readonly"] = { style = { "italic" } },
          -- ["@lsp.mod.static"] = { style = { "bold" } },
        }
      end,

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
        statusline = true,
      },

      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
    })
  end,
}
