return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<F8>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<F9>",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debug: Set Breakpoint",
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      "<F7>",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: See last session result.",
    },
    {
      -- Key mappings for evaluating expressions
      "<Leader>dh",
      "<cmd>lua require'dap.ui.widgets'.hover()<CR>",
      "Evaluate expression",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    })

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      element_mappings = {
        stacks = {
          open = "<CR>", -- Pressing Enter will open the stack frame
        },
      },
      mappings = {
        open = "o", -- Open stack frame
        toggle = "t", -- Toggle subtle frames
        -- Add other mappings as needed
      },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })
    -- dap.adapters.codelldb = {
    --   type = "server",
    --   port = "${port}",
    --   executable = {
    --     command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    --     args = { "--port", "${port}" },
    --     initCommands = {
    --       "settings set target.prefer-dynamic-values yes",
    --       "settings set target.enable-synthetic-value true",
    --     },
    --   },
    -- }
    -- dap.configurations.cpp = {
    --   {
    --     name = "Launch file",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --     end,
    --     console = "integratedTerminal",
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    --   },
    -- }

    -- debuggers
    local gdb = require("config.debug.gdb")

    dap.adapters.gdb = gdb.adapter
    dap.configurations.c = gdb.config
    dap.configurations.cpp = gdb.config

    vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
    local breakpoint_icons = { Breakpoint = "", BreakpointCondition = "", BreakpointRejected = "", LogPoint = "", Stopped = "" }
    for type, icon in pairs(breakpoint_icons) do
      local tp = "Dap" .. type
      local hl = (type == "Stopped") and "DapStop" or "DapBreak"
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
