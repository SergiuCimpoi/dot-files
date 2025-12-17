return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "rust",
        "haskell",
        "zig",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "latex",
        "query",
        "vim",
        "vimdoc",
        "regex",
        "xml",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { "ruby" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-l>",
          node_incremental = "<A-l>",
          scope_incremental = false,
          node_decremental = "<A-h>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          language_tree = true,
          additional_vim_regex_highlighting = { "org" },
        },
        textobjects = {
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ac"] = "@comment.outer",
              ["ic"] = "@comment.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["is"] = { query = "@scope", query_group = "locals" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy", -- or your preferred event
    opts = { mode = "cursor", max_lines = 7 },
    keys = {
      {
        "<leader>tc",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
          if tsc.enabled() then
            vim.notify("Enabled Treesitter Context", vim.log.levels.INFO, { title = "Option" })
          else
            vim.notify("Disabled Treesitter Context", vim.log.levels.WARN, { title = "Option" })
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
