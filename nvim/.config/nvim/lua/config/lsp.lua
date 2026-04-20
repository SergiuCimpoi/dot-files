local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function is_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local function python_has_module(python, module)
  if not is_executable(python) then
    return false
  end

  local result = vim.system({ python, "-c", "import " .. module }, { text = true }):wait()
  return result.code == 0
end

local function first_python_with_module(module)
  for _, python in ipairs({ "python3", "python", "/usr/sbin/python" }) do
    if python_has_module(python, module) then
      return python
    end
  end
  return nil
end

local function enable_if_ok(server, opts)
  local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts or {})
  vim.lsp.config(server, config)

  local cmd = config.cmd
  if cmd ~= nil then
    local exe = type(cmd) == "table" and cmd[1] or cmd
    if not exe or vim.fn.executable(exe) ~= 1 then
      vim.notify(("Skipping LSP %s: %s is not executable"):format(server, tostring(exe)), vim.log.levels.DEBUG)
      return
    end
  end

  vim.lsp.enable(server)
end

enable_if_ok("clangd", {})

enable_if_ok("lua_ls", {})

enable_if_ok("hls", {})

enable_if_ok("eslint", {

  flags = {

    allow_incremental_sync = false,
    debounce_text_changes = 1000,
  },

  settings = {
    run = "onSave",
    format = false,
    codeActionOnSave = { enable = true, mode = "all" },
  },
})

-- Only enable this if you actually work on TVM / similar FFI-heavy projects.
do
  local python = first_python_with_module("ffi_navigator")
  if python then
    vim.lsp.config("tvm_ffi_navigator", {
      capabilities = capabilities,

      cmd = { python, "-m", "ffi_navigator.langserver" },
      filetypes = { "c", "cpp", "python" },
    })
    vim.lsp.enable("tvm_ffi_navigator")
  end
end

vim.diagnostic.config({ update_in_insert = false })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
    map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
    map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and vim.lsp.protocol and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {

        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and vim.lsp.protocol and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
