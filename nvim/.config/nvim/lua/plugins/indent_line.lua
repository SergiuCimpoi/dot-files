return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function()
    local config = require("ibl.config").default_config
    config.scope.show_end = false
    config.scope.show_start = false
  end,
}
