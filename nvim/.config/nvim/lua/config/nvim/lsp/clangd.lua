return {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--all-scopes-completion",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  on_attach = function()
    vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>")
  end,
}
