return {
  {
    "mrcjkb/haskell-tools.nvim",
    ft = { "haskell", "lhaskell", "cabal" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "haskell-language-server",
        "haskell-debug-adapter",
      },
    },
  },
}
