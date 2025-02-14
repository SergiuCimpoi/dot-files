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
        javascript = { "prettierd", stop_after_first = true },
        typescript = { "prettierd", stop_after_first = true },
        javascriptreact = { "prettierd", stop_after_first = true },
        typescriptreact = { "prettierd", stop_after_first = true },
        css = { "prettierd", stop_after_first = true },
        html = { "prettierd", stop_after_first = true },
        json = { "prettierd", stop_after_first = true },
        yaml = { "prettierd", stop_after_first = true },
        markdown = { "prettierd", stop_after_first = true },
        lua = { "stylua", stop_after_first = true },
        cpp = { "clang-format", stop_after_first = true },
        xml = {
          command = vim.fn.stdpath("data") .. "/mason/packages/prettier/node_modules/.bin/prettier",
          args = { "--plugin=@prettier/plugin-xml", "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
        formatters = {
          prettierd = {
            condition = function()
              return vim.fs.normalize(".prettierrc.js") ~= nil or vim.fs.normalize(".prettierrc.mjs") ~= nil
            end,
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
