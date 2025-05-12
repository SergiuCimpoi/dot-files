local flash_enabled = true

function ToggleFlash()
  if flash_enabled then
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
    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end, { desc = "Flash" })
    vim.keymap.set("n", "S", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })
    vim.keymap.set("o", "r", function()
      require("flash").remote()
    end, { desc = "Remote Flash" })
    vim.keymap.set({ "o", "x" }, "R", function()
      require("flash").treesitter_search()
    end, { desc = "Treesitter Search" })
    flash_enabled = true
    vim.notify("Flash.nvim enabled", vim.log.levels.INFO)
  end
end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    jump = {
      autojump = true,
      pos = "start",
    },
    modes = {
      char = {
        jump_labels = true,
        multi_line = false,
      },
      search = {
        mode = "search",
      },
    },
  },
    -- stylua: ignore
    keys = {
      { "s",          mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",          mode = { "n" },           function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",          mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",          mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- Toggle mapping:
      { "<leader>jt", mode = "n",               function() ToggleFlash() end,                        desc = "Toggle Flash.nvim mappings" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
