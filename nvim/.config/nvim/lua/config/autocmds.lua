--  See `:help lua-guide-autocommands`
local group = vim.api.nvim_create_augroup("SrjAutogroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "dapui_*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function(args)
    vim.api.nvim_set_option_value("buflisted", false, { buf = args.buf })
  end,
})
