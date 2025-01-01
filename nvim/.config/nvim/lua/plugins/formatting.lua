return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        cpp = { "clang-format" },
        xml = {
          {
            command = vim.fn.stdpath("data") .. "/mason/packages/prettier/node_modules/.bin/prettier",
            args = { "--plugin=@prettier/plugin-xml", "--stdin-filepath", "$FILENAME" },
            stdin = true,
          },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    require("mason-conform").setup()
  end,
}
