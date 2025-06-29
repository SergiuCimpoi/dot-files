vim.diagnostic.config({
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
    width = 80,
  },
  virtual_text = false,
  virtual_lines = false,
  -- virtual_text = false,
  -- virtual_lines = {
  --   current_line = true,
  -- },
  severity_sort = true,
})

local virtual_lines_enabled = false
function _G.toggle_virtual_lines()
  virtual_lines_enabled = not virtual_lines_enabled
  vim.diagnostic.config({
    virtual_lines = virtual_lines_enabled and { current_line = true } or false,
    virtual_text = false,
  })
end

-- Keymap
vim.keymap.set("n", "<leader>d", toggle_virtual_lines, { desc = "Toggle diagnostic virtual lines" })
