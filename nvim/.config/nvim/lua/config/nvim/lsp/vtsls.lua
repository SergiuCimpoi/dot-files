return {
  cmd = { "vtsls", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 20,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      tsserver = {
        useSeparateSyntaxServer = true,
        experimental = {
          enableProjectDiagnostics = true,
        },
      },
      preferences = {
        importModuleSpecifier = "non-relative",
      },
    },
    refactor_auto_rename = true,
    complete_function_calls = true,
  },
  flags = {
    debounce_text_changes = 150, -- 150ms debounce for text changes
  },
}
