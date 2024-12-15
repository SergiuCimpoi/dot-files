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
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "c",
        "cpp",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
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
    end
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
    end
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
