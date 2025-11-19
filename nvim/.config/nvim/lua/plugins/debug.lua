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
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = {
        "mfussenegger/nvim-dap",
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npm run compile",
      },
    },
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
    local dap_utils = require("dap.utils")

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
            { id = "scopes", size = 0.60 },
            { id = "stacks", size = 0.20 },
            { id = "breakpoints", size = 0.20 },
          },
          size = 56,
          position = "right", -- Can be "left" or "right"
        },
        {
          elements = {
            { id = "repl", size = 0.60 },
            { id = "watches", size = 0.40 },
            -- { id = "console", size = 0.40 },
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

    -- C++
    -- local dbg = require("config.debug.lldb")
    local dbg = require("config.debug.gdb")
    -- local dbg = require("config.debug.lldb-dap")

    -- dap.adapters.lldb = dbg.adapter
    dap.adapters.gdb = dbg.adapter
    dap.configurations.c = dbg.config
    dap.configurations.cpp = dbg.config

    -- rust
    local rust_dbg = require("config.debug.codelldb")
    dap.adapters.codelldb = rust_dbg.adapter
    dap.configurations.rust = rust_dbg.config

    -- ts
    local exts = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    }
    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Adapters                                                 │
    -- ╰──────────────────────────────────────────────────────────╯
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Configurations                                           │
    -- ╰──────────────────────────────────────────────────────────╯

    for i, ext in ipairs(exts) do
      dap.configurations[ext] = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome with \"localhost\"",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = "${workspaceFolder}",
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
          skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
          resolveSourceMapLocations = {
            "${webRoot}/*",
            "${webRoot}/apps/**/**",
            "${workspaceFolder}/apps/**/**",
            "${webRoot}/packages/**/**",
            "${workspaceFolder}/packages/**/**",
            "${workspaceFolder}/*",
            "!**/node_modules/**",
          },
        },
        {
          name = "Next.js: debug server-side (pwa-node)",
          type = "pwa-node",
          request = "attach",
          port = 9231,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (pwa-node)",
          cwd = vim.fn.getcwd(),
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          runtimeExecutable = "pnpm",
          runtimeArgs = {
            "run-script",
            "dev",
          },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (pwa-node with ts-node)",
          cwd = vim.fn.getcwd(),
          runtimeArgs = { "--loader", "ts-node/esm" },
          runtimeExecutable = "node",
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Test Current File (pwa-node with jest)",
          cwd = vim.fn.getcwd(),
          runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
          runtimeExecutable = "node",
          args = { "${file}", "--coverage", "false" },
          rootPath = "${workspaceFolder}",
          sourceMaps = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Test Current File (pwa-node with vitest)",
          cwd = vim.fn.getcwd(),
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
          autoAttachChildProcesses = true,
          smartStep = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Test Current File (pwa-node with deno)",
          cwd = vim.fn.getcwd(),
          runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
          runtimeExecutable = "deno",
          attachSimplePort = 9229,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach Program (pwa-chrome, select port)",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = function()
            return vim.fn.input("Select port: ", 9222)
          end,
          webRoot = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
          resolveSourceMapLocations = {
            "${webRoot}/*",
            "${webRoot}/apps/**/**",
            "${workspaceFolder}/apps/**/**",
            "${webRoot}/packages/**/**",
            "${workspaceFolder}/packages/**/**",
            "${workspaceFolder}/*",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach Program (pwa-node, select pid)",
          cwd = vim.fn.getcwd(),
          processId = dap_utils.pick_process,
          skipFiles = { "<node_internals>/**" },
        },
      }
    end

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
