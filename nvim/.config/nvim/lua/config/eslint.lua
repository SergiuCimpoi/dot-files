return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern(
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      "package.json",
      ".git"
    )(fname)
  end,
  settings = {
    -- Custom ESLint settings if needed
  },
}
