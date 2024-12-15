-- This file needs to have same structure as nvconfig.lua https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua Please read that file to know all available options :( This file needs to have same structure as nvconfig.lua https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua Please read that file to know all available options :( This file needs to have same structure as nvconfig.lua https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua Please read that file to know all available options :( This file needs to have same structure as nvconfig.lua https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  -- transparency = true,
  ---@diagnostic disable-next-line: missing-fields
  hl_override = {
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  telescope = {
    style = "bordered",
  },
}

M.mason = {
  pkgs = {
    -- Language servers
    "lua-language-server",
    "clangd",
    -- Formatters
    "stylua",
    "clang-format",
    -- Linters
    "luacheck",
    "cpplint",
    -- Debuggers
    "codelldb",
  },
  skip = {},
}

-- Extend NvChad's functionality
local function setup_mason_auto_install()
  local mason_registry = require("mason-registry")
  local pkgs = M.mason.pkgs
  ---@diagnostic disable-next-line: undefined-field
  local skip = M.mason.skip

  if pkgs == nil then
    return
  end

  -- Helper to check and install
  local function ensure_installed(pkg)
    if not mason_registry.get_package(pkg):is_installed() then
      mason_registry.get_package(pkg):install()
    end
  end

  -- Iterate over pkgs and ensure installation
  for _, pkg in ipairs(pkgs) do
    if not vim.tbl_contains(skip, pkg) then
      ensure_installed(pkg)
    end
  end
end

-- Hook into Mason
vim.defer_fn(setup_mason_auto_install, 0)

return M
