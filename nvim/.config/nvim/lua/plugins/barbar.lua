return {
  "romgrk/barbar.nvim",
  version = "^1.0.0",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require("barbar").setup({
      animation = false,
      auto_hide = false,
      tabpages = false,
      clickable = true,
      focus_on_close = "left",
      highlight_alternate = false,
      highlight_visible = true,
      insert_at_end = false,
      insert_at_start = false,
      maximum_padding = 1,
      minimum_padding = 1,
      maximum_length = 30,
      minimum_length = 0,
      semantic_letters = true,
      no_name_title = "[No Name]",
      sidebar_filetypes = {
        ["neo-tree"] = { event = "BufWipeout", text = "Explorer", align = "left" },
      },
      icons = {
        buffer_index = true,
        buffer_number = false,
        button = "󰅖",
        filetype = {
          enabled = true,
          custom_colors = false,
        },
        separator = { left = "", right = "" },
        separator_at_end = false,
        modified = { button = "●" },
        pinned = { button = "", filename = true },
        preset = "default",
        inactive = { button = "×" },
        current = { buffer_index = true },
        visible = { modified = { buffer_number = false } },
      },
      sort = {
        ignore_case = true,
      },
    })

    local map = vim.keymap.set
    local opts = { silent = true }

    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
    map("n", "<leader>bp", "<Cmd>BufferPin<CR>", opts)
    map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts)
    map("n", "<leader>br", "<Cmd>BufferRestore<CR>", opts)
    map("n", "<leader>bj", "<Cmd>BufferPick<CR>", opts)
    map("n", "<leader>bD", "<Cmd>BufferPickDelete<CR>", opts)

    for i = 1, 9 do
      map("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", { desc = "Buffer " .. i, silent = true })
    end
    map("n", "<leader>0", "<Cmd>BufferLast<CR>", { desc = "Last buffer", silent = true })

    local groups = {
      "BufferCurrent",
      "BufferCurrentIndex",
      "BufferCurrentBtn",
      "BufferCurrentMod",
      "BufferCurrentSign",
      "BufferCurrentSignRight",
      "BufferVisible",
      "BufferVisibleIndex",
      "BufferVisibleBtn",
      "BufferVisibleMod",
      "BufferVisibleSign",
      "BufferVisibleSignRight",
      "BufferInactive",
      "BufferInactiveIndex",
      "BufferInactiveBtn",
      "BufferInactiveMod",
      "BufferInactiveSign",
      "BufferInactiveSignRight",
      "BufferAlternate",
      "BufferAlternateIndex",
      "BufferAlternateBtn",
      "BufferAlternateMod",
      "BufferAlternateSign",
      "BufferAlternateSignRight",
      "BufferOffset",
      "BufferTabpageFill",
      "BufferScrollArrow",
      "BufferTabpages",
      "BufferTabpagesSep",
    }

    local blue = "#89B4FA"
    local text = "#CDD6F4"
    local muted = "#BAC2DE"

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        for _, g in ipairs(groups) do
          vim.api.nvim_set_hl(0, g, { bg = "none" })
        end

        vim.api.nvim_set_hl(0, "BufferCurrent", { fg = blue, bg = "none", bold = true })
        vim.api.nvim_set_hl(0, "BufferCurrentIndex", { fg = blue, bg = "none", bold = true })
        vim.api.nvim_set_hl(0, "BufferCurrentBtn", { fg = blue, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferCurrentMod", { fg = blue, bg = "none" })

        vim.api.nvim_set_hl(0, "BufferVisible", { fg = text, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferVisibleIndex", { fg = text, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferVisibleBtn", { fg = text, bg = "none" })

        vim.api.nvim_set_hl(0, "BufferInactive", { fg = muted, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferInactiveIndex", { fg = muted, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferInactiveBtn", { fg = muted, bg = "none" })

        vim.api.nvim_set_hl(0, "BufferOffset", { fg = muted, bg = "none" })
        vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "none" })
      end,
    })
  end,
}
