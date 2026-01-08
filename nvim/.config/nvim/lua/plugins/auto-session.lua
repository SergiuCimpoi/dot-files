return {
  "rmagatti/auto-session",
  lazy = false,

  opts = {
    suppressed_dirs = { "~/", "~/Dev/", "~/Downloads/", "~/Documents/", "~/Desktop/" },
  },
  keys = {
    { "<leader>sr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },
    { "<leader>ss", "<cmd>AutoSession save<CR>", desc = "Save session for cwd" },
  },
}
