return {
  adapter = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },
      -- initCommands = {
      --   "settings set target.prefer-dynamic-values yes",
      --   "settings set target.enable-synthetic-value true",
      -- },
    },
  },
  config = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      console = "integratedTerminal",
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  },
}
