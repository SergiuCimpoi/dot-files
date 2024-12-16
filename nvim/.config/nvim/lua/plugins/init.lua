return {
  {
    require("configs.conform"),
  },
  {
    require("configs.nvim-lint"),
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {

      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "haskell",
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
        "bash",
        "lua",
        "vim",
        "gitignore",
        "vimdoc",
        "c",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-,>",
          node_incremental = "<C-,>",
          scope_incremental = false,
          node_decremental = "<C-.>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvim-tree").opts,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      }
      conf.file_ignore_patterns = {
        "build/", -- Ignore the build directory
        ".clangd/", -- Ignore the clangd cache directory
        "*/build/*", -- Ignore any build directories in subdirectories
        "*/.clangd/*", -- Ignore clangd cache in subdirectories
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      -- require("nvchad.utils").load_mappings "dap"
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      local dap = require("dap")

      keymap("n", "<F5>", dap.continue, opts) -- Start/continue debugging
      keymap("n", "<F10>", dap.step_over, opts) -- Step over
      keymap("n", "<F11>", dap.step_into, opts) -- Step into
      keymap("n", "<F12>", dap.step_out, opts) -- Step out
      keymap("n", "<leader>db", dap.toggle_breakpoint, opts) -- Toggle breakpoint
      keymap("n", "<leader>dr", dap.repl.open, opts) -- Open REPL
      keymap("n", "<leader>dl", dap.run_last, opts) -- Run last debug session
    end,
  },
  -- cmake-tools
  {
    require("configs.cmake-tools"),
  },
  -- surround
  {
    require("configs.surround"),
  },
  {
    -- Detect tabstop and shift"idth automatically
    "tpope/vim-sleuth",
  },
  {
    -- Po"erful Git integration for Vim
    "tpope/vim-fugitive",
  },
  {
    -- GitHub integration for vim-fugitive
    "tpope/vim-rhubarb",
  },
  -- comment
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {
      -- add any options here
    },
  },
  {
    require("configs.auto-session"),
  },
  {
    require("configs.trouble"),
  },
  {
    require("configs.lazygit"),
  },
  -- {
  --  "stevearc/dressing.nvim",
  --  	event = "VeryLazy",
  -- },
  -- {
  --   require "configs.neo-tree"
  -- },
  -- {
  --   require "configs.surround"
  -- }
}
