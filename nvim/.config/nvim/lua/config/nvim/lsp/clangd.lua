return {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--all-scopes-completion",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--background-index=false",
    "--header-insertion=iwyu",
    "--crash-prone-features=off", -- Extra stability
  },
}
-- on_attach = function()
--   vim.keymap.set("n", "<A-o>", "<cmd>LspClangdSwitchSourceHeader<CR>")
-- end,
