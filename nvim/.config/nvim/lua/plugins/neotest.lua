return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "alfaix/neotest-gtest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-gtest").setup({
          -- root = function()
          --   return vim.loop.cwd()
          -- end,
        }),
      },
    })
    vim.keymap.set("n", "<leader>ts", function()
      local success, err = pcall(require("neotest").summary.toggle)
      if not success then
        print("Error toggling Neotest summary: " .. err)
      end
    end, { desc = "Toggle Neotest Summary" })

    vim.keymap.set("n", "<leader>gt", ":lua require('neotest').summary.open()<CR>", { silent = true, desc = "Open Neotest summary" })
  end,
}
