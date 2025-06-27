return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "clangd", "lua_ls", "vtsls", "eslint", "hls" },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
