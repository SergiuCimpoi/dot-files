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
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  --       multiwindow = false, -- Enable multiwindow support.
  --       max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  --       min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  --       line_numbers = true,
  --       multiline_threshold = 20, -- Maximum number of lines to show for a single context
  --       trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  --       mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  --       -- Separator between context and content. Should be a single character string, like '-'.
  --       -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  --       separator = nil,
  --       zindex = 20, -- The Z-index of the context window
  --       on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  --     })
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy", -- or your preferred event
    opts = { mode = "cursor", max_lines = 3 },
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
