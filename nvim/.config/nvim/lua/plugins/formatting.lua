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
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        lua = { "stylua" },
        cpp = { "clang-format" },
        xml = {
          {
            command = vim.fn.stdpath("data") .. "/mason/packages/prettier/node_modules/.bin/prettier",
            args = { "--plugin=@prettier/plugin-xml", "--stdin-filepath", "$FILENAME" },
            stdin = true,
          },
        },
        formatters = {
          prettierd = {
            condition = function()
              return vim.fs.normalize(".prettierrc.js") ~= nil or vim.fs.normalize(".prettierrc.mjs") ~= nil
            end,
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
