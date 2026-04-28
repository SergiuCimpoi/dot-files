return {
  "puremourning/vimspector",
  ft = { "c", "cpp", "rust", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    vim.g.vimspector_enable_mappings = "HUMAN"

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<F5>", "<Plug>VimspectorContinue", opts)
    map("n", "<F8>", "<Plug>VimspectorToggleBreakpoint", opts)
    map("n", "<F9>", "<Plug>VimspectorAddFunctionBreakpoint", opts)
    map("n", "<F10>", "<Plug>VimspectorStepOver", opts)
    map("n", "<F11>", "<Plug>VimspectorStepInto", opts)
    map("n", "<F12>", "<Plug>VimspectorStepOut", opts)

    map("n", "<F4>", "<Plug>VimspectorStop", opts)
    map("n", "<F3>", "<Plug>VimspectorToggleBreakpoint", opts)

    map("n", "<leader>dd", "<cmd>call vimspector#Launch()<CR>", opts)
    map("n", "<leader>dr", "<cmd>call vimspector#Restart()<CR>", opts)
    map("n", "<leader>de", "<cmd>call vimspector#Reset()<CR>", opts)

    map("n", "<leader>dh", "<Plug>VimspectorBalloonEval", opts)
    map("x", "<leader>dh", "<Plug>VimspectorBalloonEval", opts)
  end,
}
