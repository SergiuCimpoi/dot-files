local function goto_definition()
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
  if not client then
    print("No active LSP client found")
    return
  end

  local encoding = client.offset_encoding or "utf-16"
  local params = vim.lsp.util.make_position_params(0, encoding)
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
    if err then
      print("Error fetching definitions: " .. err.message)
      return
    end

    if not result or vim.tbl_isempty(result) then
      print("No definitions found")
      return
    end

    -- If there's only one definition, jump to it directly
    if #result == 1 then
      local def = result[1]
      local uri = def.uri or def.targetUri
      local range = def.range or def.targetRange

      -- Convert URI to buffer number
      local target_bufnr = vim.uri_to_bufnr(uri)

      -- Load the buffer if it's not already loaded
      if not vim.api.nvim_buf_is_loaded(target_bufnr) then
        vim.fn.bufload(target_bufnr)
      end

      -- Ensure the buffer is listed
      vim.api.nvim_set_option_value("buflisted", true, { buf = target_bufnr })

      -- Check if the buffer is already open in a window
      local win_id = vim.fn.bufwinid(target_bufnr)

      if win_id ~= -1 then
        -- Buffer is visible, switch to its window
        vim.api.nvim_set_current_win(win_id)
      else
        -- Buffer is not visible, open it in the current window
        vim.api.nvim_command("buffer " .. target_bufnr)
      end

      -- Move cursor to the definition location
      vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
    else
      -- More than one definition, use fzf picker (or any other UI picker you prefer)
      require("fzf-lua").lsp_definitions()
    end
  end)
end

-- Optionally bind this function to a key mapping
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua goto_definition()<CR>", { noremap = true, silent = true })
return {
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("gd", goto_definition, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
          if client and vim.lsp.protocol and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

          ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
          if client and vim.lsp.protocol and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local function get_lua_runtime()
        local result = {}
        for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
          local lua_path = path .. "/lua/"
          if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
          end
        end
        result[vim.fn.expand("$VIMRUNTIME/lua")] = true
        result[vim.fn.expand("~/dev/neovim/src/nvim/lua")] = true

        return result
      end

      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--clang-tidy",
            "--clang-tidy-checks=*",
            "--all-scopes-completion",
            "--cross-file-rename",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
          },
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<A-o>", "<CMD>ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
          end,
        },
        eslint = {
          settings = {
            packageManager = "pnpm",
          },
          ---@diagnostic disable-next-line: unused-local
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              hint = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              runtime = {
                version = "LuaJIT",
                path = { "?.lua", "?/init.lua" },
              },
              workspace = {
                checkThirdParty = false,
                library = get_lua_runtime(),
                ignoreDir = "~/.config/nvim/backups",
                maxPreload = 10000,
                preloadFileSize = 10000,
              },
              diagnostics = { disable = { "missing-fields" } },
              format = {
                enable = false,
              },
            },
          },
        },
      }

      require("mason").setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
}
