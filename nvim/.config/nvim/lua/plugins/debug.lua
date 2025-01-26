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
      desc = "DAP Start/Continue",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "DAP Step Into",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "DAP Step Over",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "DAP Step Out",
    },
    {
      "<F8>",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "DAP Toggle Breakpoint",
    },
    {
      "<F9>",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "DAP Set Conditional Breakpoint",
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      "<F3>",
      function()
        require("dapui").toggle()
      end,
      desc = "DAP toggle",
    },
    {
      -- Key mappings for evaluating expressions
      "<Leader>dh",
      "<cmd>lua require'dap.ui.widgets'.hover()<CR>",
      desc = "DAP Evaluate expression",
    },
    {
      "<F4>",
      "<cmd>lua require('dap').terminate()<CR>",
      desc = "DAP terminate",
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
      layouts = {
        -- Changing the layout order will give more space to the first element
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- { id = "scopes", size = 0.25, },
            { id = "stacks", size = 0.50 },
            { id = "breakpoints", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 56,
          position = "right", -- Can be "left" or "right"
        },
        {
          elements = {
            { id = "repl", size = 0.60 },
            { id = "console", size = 0.40 },
          },
          size = 8,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
      -- icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
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
    })

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
