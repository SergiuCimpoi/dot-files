return {
  settings = {
    Lua = {
      hint = { enable = true },
      completion = { callSnippet = "Replace" },
      runtime = {
        version = "LuaJIT",
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
        library = get_lua_runtime(),
        ignoreDir = "~/.config/nvim/backups",
        maxPreload = 10000,
        preloadFileSize = 10000,
      },
      diagnostics = { disable = { "missing-fields" } },
      format = { enable = false },
    },
  },
}
