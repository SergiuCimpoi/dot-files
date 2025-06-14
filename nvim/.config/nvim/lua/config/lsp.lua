vim.lsp.enable({ "clangd", "lua_ls", "tsserver" })
vim.lsp.config("eslint", require("config.eslint"))

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
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
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

-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = {
--     { "williamboman/mason.nvim", config = true },
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--     "j-hui/fidget.nvim",
--     -- "hrsh7th/cmp-nvim-lsp",
--   },
--   config = function()
--     vim.api.nvim_create_autocmd("LspAttach", {
--       group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
--       callback = function(event)
--         local map = function(keys, func, desc, mode)
--           mode = mode or "n"
--           vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--         end
--
--         map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
--         map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
--         map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
--         map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
--         map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
--         map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
--         map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
--         map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
--         map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         if client and vim.lsp.protocol and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
--           local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
--           vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--             buffer = event.buf,
--             group = highlight_augroup,
--             callback = vim.lsp.buf.document_highlight,
--           })
--           vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--             buffer = event.buf,
--             group = highlight_augroup,
--             callback = vim.lsp.buf.clear_references,
--           })
--           vim.api.nvim_create_autocmd("LspDetach", {
--             group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
--             callback = function(event2)
--               vim.lsp.buf.clear_references()
--               vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
--             end,
--           })
--         end
--
--         if client and vim.lsp.protocol and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
--           map("<leader>th", function()
--             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
--           end, "[T]oggle Inlay [H]ints")
--         end
--       end,
--     })
--
--     local default_capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
--
--     local function get_lua_runtime()
--       local result = {}
--       for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
--         local lua_path = path .. "/lua/"
--         if vim.fn.isdirectory(lua_path) then
--           result[lua_path] = true
--         end
--       end
--       result[vim.fn.expand("$VIMRUNTIME/lua")] = true
--       result[vim.fn.expand("~/dev/neovim/src/nvim/lua")] = true
--       return result
--     end
--
--     local servers = {
--       vtsls = {
--         filetypes = {
--           "javascript",
--           "javascriptreact",
--           "javascript.jsx",
--           "typescript",
--           "typescriptreact",
--           "typescript.tsx",
--         },
--         settings = {
--           complete_function_calls = true,
--           vtsls = {
--             enableMoveToFileCodeAction = true,
--             autoUseWorkspaceTsdk = true,
--             experimental = {
--               maxInlayHintLength = 30,
--               completion = {
--                 enableServerSideFuzzyMatch = true,
--               },
--             },
--           },
--           typescript = {
--             updateImportsOnFileMove = { enabled = "always" },
--             suggest = {
--               completeFunctionCalls = true,
--             },
--             inlayHints = {
--               enumMemberValues = { enabled = true },
--               functionLikeReturnTypes = { enabled = true },
--               parameterNames = { enabled = "literals" },
--               parameterTypes = { enabled = true },
--               propertyDeclarationTypes = { enabled = true },
--               variableTypes = { enabled = false },
--             },
--           },
--         },
--       },
--       clangd = {
--         cmd = {
--           "clangd",
--           "--clang-tidy",
--           "--clang-tidy-checks=*",
--           "--all-scopes-completion",
--           "--cross-file-rename",
--           "--completion-style=detailed",
--           "--header-insertion=iwyu",
--         },
--         on_attach = function()
--           vim.keymap.set("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>")
--         end,
--       },
--       eslint = {
--         settings = {
--           packageManager = "pnpm",
--         },
--         on_attach = function(client, bufnr)
--           vim.api.nvim_create_autocmd("BufWritePre", {
--             buffer = bufnr,
--             command = "EslintFixAll",
--           })
--         end,
--       },
--       lua_ls = {
--         settings = {
--           Lua = {
--             hint = { enable = true },
--             completion = { callSnippet = "Replace" },
--             runtime = {
--               version = "LuaJIT",
--               path = { "?.lua", "?/init.lua" },
--             },
--             workspace = {
--               checkThirdParty = false,
--               library = get_lua_runtime(),
--               ignoreDir = "~/.config/nvim/backups",
--               maxPreload = 10000,
--               preloadFileSize = 10000,
--             },
--             diagnostics = { disable = { "missing-fields" } },
--             format = { enable = false },
--           },
--         },
--       },
--     }
--
--     -- Map lspconfig server names to mason package names
--     local mason_pkg_map = {
--       lua_ls = "lua-language-server",
--       vtsls = "vtsls",
--       clangd = "clangd",
--       eslint = "eslint-lsp",
--     }
--     local mason_ensure = {}
--     for server, _ in pairs(servers) do
--       if mason_pkg_map[server] then
--         table.insert(mason_ensure, mason_pkg_map[server])
--       end
--     end
--
--     require("mason").setup({})
--     require("mason-tool-installer").setup({
--       ensure_installed = mason_ensure,
--     })
--
--     for server, opts in pairs(servers) do
--       opts.capabilities = capabilities
--       require("lspconfig")[server].setup(opts)
--     end
--   end,
-- }
