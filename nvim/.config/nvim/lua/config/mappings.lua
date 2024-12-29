local wk = require("which-key")

vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move end of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "General save file" })
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General copy whole file" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<leader>", "<Nop>", { silent = true })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", "\"_x", opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>bx", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>bn", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts) -- close current split window

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", "\"_dP", opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- CMake
vim.keymap.set("", "<leader>cg", ":CMakeGenerate<CR>", { desc = "CMake Generate" })
vim.keymap.set("", "<leader>cb", ":CMakeBuild<CR>", { desc = "CMake Build" })
vim.keymap.set("", "<leader>cq", ":CMakeClose<CR>", { desc = "CMake Close" })
vim.keymap.set("", "<leader>cc", ":CMakeClean<CR>", { desc = "CMake Clean" })

-- Obsession
vim.keymap.set("n", "<Leader>ss", ":Obsession<CR>", { silent = true })
vim.keymap.set("n", "<Leader>sp", ":Obsession!<CR>", { silent = true })

-- fzf
-- local builtin = require("fzf-lua")
-- vim.keymap.set("n", "<leader>fh", builtin.helptags, { desc = "[F]ind [H]elp" })
-- vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
-- vim.keymap.set("n", "<leader>ff", builtin.files, { desc = "[F]ind [F]iles" })
-- vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
-- vim.keymap.set("n", "<leader>fw", builtin.grep_cword, { desc = "[F]ind current [W]ord" })
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
-- vim.keymap.set("n", "<leader>fd", builtin.diagnostics_workspace, { desc = "[F]ind [D]iagnostics" })
-- vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
-- vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "[F]ind Recent Files (\".\" for repeat)" })
-- -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
--
-- -- Slightly advanced example of overriding default behavior and theme
-- vim.keymap.set("n", "<leader>/", function()
--   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--   builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
--     winblend = 10,
--     previewer = false,
--   }))
-- end, { desc = "[/] Fuzzily search in current buffer" })
--
-- -- It's also possible to pass additional configuration options.
-- --  See `:help telescope.builtin.live_grep()` for information about particular keys
-- vim.keymap.set("n", "<leader>s/", function()
--   builtin.live_grep({
--     grep_open_files = true,
--     prompt_title = "Live Grep in Open Files",
--   })
-- end, { desc = "[F]ind [/] in Open Files" })
--
-- -- Shortcut for searching your Neovim configuration files
-- vim.keymap.set("n", "<leader>sn", function()
--   builtin.find_files({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "[F]ind [N]eovim files" })
