return {
  adapter = {
    type = "executable",
    command = "lldb-dap", -- adjust path as needed
    name = "lldb",
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    },
    initCommands = {
      "settings set symbols.load-on-demand true",
      "settings set target.preload-symbols false",
    },
  },
  config = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  },
}
