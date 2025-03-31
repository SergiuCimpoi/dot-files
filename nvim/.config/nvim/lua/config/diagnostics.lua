vim.diagnostic.config({
  open_float = {
    width = 80,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  float = {
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  severity_sort = true,
})
