require("config.options")
require("config.diagnostics")
require("config.bindings")
require("config.lazy")

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

-- vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LspFloatWinNormal", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "LspFloatWinBorder", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = "NONE" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "NONE" })
--
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
