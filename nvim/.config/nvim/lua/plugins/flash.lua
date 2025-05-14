local flash_opts = {
  jump = {
    autojump = true,
    pos = "start",
  },
  modes = {
    char = {
      enabled = true,
      jump_labels = true,
      multi_line = false,
    },
    search = {
      mode = "search",
    },
  },
}

local flash_enabled = true

local function remove_flash_char_maps()
  for _, key in ipairs({ "f", "F", "t", "T" }) do
    pcall(vim.keymap.del, "n", key)
    pcall(vim.keymap.del, "x", key)
    pcall(vim.keymap.del, "o", key)
  end
end

local function restore_flash_char_maps()
  -- This is a workaround: reload flash.nvim's char mode mappings
  -- The cleanest way is to re-require the plugin and call setup again
  require("flash").setup(flash_opts)
end

function ToggleFlash()
  local flash = require("flash")
  if flash_enabled then
    -- Remove char mode and custom keymaps
    remove_flash_char_maps()
    vim.keymap.del("n", "s")
    vim.keymap.del("x", "s")
    vim.keymap.del("o", "s")
    vim.keymap.del("n", "S")
    vim.keymap.del("o", "r")
    vim.keymap.del("o", "R")
    vim.keymap.del("x", "R")
    flash_enabled = false
    vim.notify("Flash.nvim disabled", vim.log.levels.INFO)
  else
    -- Restore all mappings
    restore_flash_char_maps()
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      flash.jump()
    end, { desc = "Flash" })
    vim.keymap.set("n", "S", function()
      flash.treesitter()
    end, { desc = "Flash Treesitter" })
    vim.keymap.set("o", "r", function()
      flash.remote()
    end, { desc = "Remote Flash" })
    vim.keymap.set({ "o", "x" }, "R", function()
      flash.treesitter_search()
    end, { desc = "Treesitter Search" })
    flash_enabled = true
    vim.notify("Flash.nvim enabled", vim.log.levels.INFO)
  end
end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = flash_opts,
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<leader>jt",
      mode = "n",
      function()
        ToggleFlash()
      end,
      desc = "Toggle Flash.nvim mappings",
    },
  },
}
