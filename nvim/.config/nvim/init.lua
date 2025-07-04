vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Wrapping
vim.o.wrap = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.cursorcolumn = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

vim.o.showmatch = true
vim.o.matchtime = 3

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = "1"
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.listchars = {
  -- space = "⋅",
  -- eol = "↴",
  tab = "▎_",
  -- tab = ">.",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "",
}
vim.opt.fillchars = {
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
  diff = "╱",
  eob = " ",
}

vim.opt.shortmess:append("W")
vim.opt.shortmess:append("A")
vim.opt.shortmess:append("F")

-- Import mappings
require("config.lazy")
require("config.diagnostics")
require("config.mappings")
require("config.autocmds")
require("config.lsp")

local function is_wsl()
  local uname_output = vim.fn.system("uname -r")
  if uname_output:find("Microsoft") then
    return true
  elseif vim.fn.exists("$WSL_DISTRO_NAME") ~= 0 then
    return true
  else
    return false
  end
end

-- Check if running in WSL and print message
WSL = is_wsl()

if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_vfx_particle_density = 10.0
  vim.g.neovide_cursor_vfx_opacity = 150.0
end
