return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  ft = { "rust" },
  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "check",
              extraArgs = {},
            },
          },
        },
      },
    }
  end,
}
