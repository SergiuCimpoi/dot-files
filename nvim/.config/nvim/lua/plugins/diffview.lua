return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("diffview").setup({
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = false, -- Use enhanced highlight for diffs
      git_cmd = { "git" }, -- Git executable and default args
      use_icons = true, -- Enables nvim-web-devicons
      show_help_hints = true, -- Show help panel hints
      watch_index = true, -- Auto-refresh on git index change
      icons = { -- Custom folder and sign icons
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        merge_tool = {
          layout = "diff3_horizontal", -- 3-way diff for merge conflicts
          disable_diagnostics = true, -- Disable diagnostics in diff buffers
        },
        default = {
          layout = "diff2_horizontal", -- 2-way diff horizontal layout
        },
      },
      file_panel = {
        listing_style = "tree", -- File list style: 'tree' or 'list'
        tree_options = {
          flatten_dirs = true, -- Flatten one-directory trees
          folder_statuses = "only_folded", -- Folder status style
        },
      },
      file_history_panel = {
        log_options = {
          single_file = {
            diff_merges = "combined",
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },
    })
  end,
}
