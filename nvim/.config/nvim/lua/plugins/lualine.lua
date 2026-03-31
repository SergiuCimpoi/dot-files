return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
      end,
    }

    local filename = {
      "filename",
      file_status = true,
      path = 1,
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " },
      cond = hide_in_width,
    }

    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
        always_show_tabline = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },

      sections = {
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          { "encoding", cond = hide_in_width },
          { "filetype", cond = hide_in_width },
        },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },

      -- tabline = {
      --   lualine_c = {
      --     {
      --       "buffers",
      --       mode = 2,
      --       show_filename_only = true,
      --       hide_filename_extension = false,
      --       show_modified_status = true,
      --       use_mode_colors = false,
      --       max_length = vim.o.columns * 2 / 3,
      --       separator = "",
      --       padding = { left = 1, right = 1 },
      --       symbols = {
      --         modified = " ●",
      --         alternate_file = "",
      --         directory = "",
      --       },
      --       buffers_color = {
      --         active = { fg = "#89B4FA", bg = "none", gui = "bold" },
      --         inactive = { fg = "#BAC2DE", bg = "none" },
      --       },
      --       filetype_names = {
      --         TelescopePrompt = "Telescope",
      --         dashboard = "Dashboard",
      --         alpha = "Alpha",
      --         ["neo-tree"] = "Explorer",
      --       },
      --     },
      --   },
      -- },

      extensions = {
        "fugitive",
        "neo-tree",
        "nvim-dap-ui",
        "trouble",
        "fzf",
        "quickfix",
      },
    })

    -- for i = 1, 9 do
    --   vim.keymap.set("n", "<leader>" .. i, function()
    --     vim.cmd("LualineBuffersJump " .. i)
    --   end, { desc = "Buffer " .. i })
    -- end
  end,
}
