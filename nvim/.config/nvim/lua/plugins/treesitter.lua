return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "rust",
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
        "query",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { "ruby" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-,>",
          node_incremental = "<A-,>",
          scope_incremental = false,
          node_decremental = "<A-.>",
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
}
