require "nvchad.options"

local config = vim.fn.stdpath "config"

-- Completion
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience (default: 'menu,preview')
vim.o.pumheight = 10 -- Pop up menu height (default: 0)
vim.o.wildoptions = "pum,tagfile,fuzzy" -- Enable fuzzy finding commands

-- Softwrap
vim.o.wrap = false -- Display lines as one long line (default: true)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.o.breakindent = true -- Enable break indent (default: false)
vim.o.showbreak = " " -- Wrap indicator

-- Status column
vim.wo.number = true -- Make line numbers default (default: false)
vim.o.relativenumber = true -- Set relative numbered lines (default: false)

-- Cursor
vim.o.cursorlineopt = "both" -- Highlight both line and line number
vim.o.cursorline = true -- Highlight the current line (default: false)
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#282a3e" })

-- Spell
vim.o.spellfile = config .. "/spell/en.utf-8.add," .. config .. "/spell/pt.utf-8.add" -- Custom dictionary files
vim.o.spelllang = "en,pt_br" -- Languages to spell check
vim.o.spelloptions = "camel" -- Consider camelCase when checking spell
vim.o.spellsuggest = "best,9" -- Limit the number of suggestions for spell

-- Folds
vim.o.foldtext = "" -- Highlight folds
vim.o.foldlevelstart = 99 -- Don't close any folds at the start

-- Splits
vim.o.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.o.splitright = true -- Force all vertical splits to go to the right of current window (default: false)
vim.o.splitkeep = "screen" -- Keep the same relative cursor position when splitting

-- Indentation
vim.o.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.o.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.o.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.o.expandtab = true -- Convert tabs to spaces (default: false)
vim.o.shiftround = true -- Round indent to multiple of 'shiftwidth'

-- Misc
vim.o.gdefault = true -- Replace all line matches during substitution
vim.o.updatetime = 250 -- Decrease update time (default: 4000)
vim.o.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.clipboard = "unnamed,unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
vim.o.fillchars = [[eob: ,fold: ,foldopen:󰅀,foldsep: ,foldclose:󰅂]] -- Fancy fold symbols
vim.o.jumpoptions = "view" -- Prevents moving cursor when switching files
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.o.undofile = true -- Save undo history (default: false)
vim.o.shadafile = "NONE" -- Don't save history
vim.o.title = true -- Title for the Neovim Window
vim.o.swapfile = false -- Creates a swapfile (default: true)
vim.o.mouse = "a" -- Enable mouse mode (default: '')
vim.o.autoindent = true -- Copy indent from current line when starting new one (default: true)
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.smartcase = true -- Smart case (default: false)
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.o.hlsearch = false -- Set highlight on search (default: true)
vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.numberwidth = 4 -- Set number column width to 2 {default 4} (default: 4)
vim.o.smartindent = true -- Make indenting smarter again (default: false)
vim.o.showtabline = 2 -- Always show tabs (default: 1)
vim.o.backspace = "indent,eol,start" -- Allow backspace on (default: 'indent,eol,start')
vim.o.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)
vim.wo.signcolumn = "yes" -- Keep signcolumn on by default (default: 'auto')
vim.o.fileencoding = "utf-8" -- The encoding written to a file (default: 'utf-8')
vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.o.timeoutlen = 1000 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.o.backup = false -- Creates a backup file (default: false)
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.opt.shortmess:append "c" -- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.iskeyword:append "-" -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.formatoptions:remove { "c", "r", "o" } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.runtimepath:remove "/usr/share/vim/vimfiles" -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
