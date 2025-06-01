--  See `:help lua-guide-autocommands`
local group = vim.api.nvim_create_augroup("SrjAutogroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  group = group,
  pattern = "dapui_*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  pattern = "dap-repl",
  callback = function(args)
    vim.api.nvim_set_option_value("buflisted", false, { buf = args.buf })
  end,
})
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    local msg = string.format("Register:  %s", vim.fn.reg_recording())
    _MACRO_RECORDING_STATUS = true
    vim.notify(msg, vim.log.levels.INFO, {
      title = "Macro Recording",
      keep = function()
        return _MACRO_RECORDING_STATUS
      end,
    })
  end,
  group = vim.api.nvim_create_augroup("NoiceMacroNotfication", { clear = true }),
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    _MACRO_RECORDING_STATUS = false
    vim.notify("Success!", vim.log.levels.INFO, {
      title = "Macro Recording End",
      timeout = 2000,
    })
  end,
  group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", { clear = true }),
})
vim.api.nvim_buf_create_user_command(0, "ClangdSwitchSourceHeader", function()
  local params = { uri = vim.uri_from_bufnr(0) }
  vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      print("Corresponding file can't be determined")
      return
    end
    vim.cmd("edit " .. vim.uri_to_fname(result))
  end)
end, {})
-- autosave files every second
vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { pattern = "*", command = "checktime" })
