local function yank_buffer_path()
  local full_path = vim.api.nvim_buf_get_name(0) -- Get the full path of the current buffer
  vim.fn.setreg("+", full_path) -- Yank to the system clipboard (register '+')
  print("Yanked buffer path: " .. full_path) -- Optional: Display the yanked path
end

vim.keymap.set("n", "<leader>yp", yank_buffer_path, { noremap = true, silent = true })

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

-- visually Yanks and positions after the selection
-- vim.keymap.set({ "x", "s" }, "ya", "ygv<Esc>", { noremap = true, desc = "[Y]ank and go [A]fter" })
vim.keymap.set({ "x", "s" }, "ya", "y`>", { noremap = true, desc = "[Y]ank and go [A]fter" })

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<leader>", "<Nop>", { silent = true })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- For conciseness
local opts = { noremap = true, silent = true }
local opts_with_desc = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

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
vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>", opts_with_desc("next buffer"))
vim.keymap.set("n", "<leader><S-Tab>", ":bprevious<CR>", opts_with_desc("previous buffer"))
vim.keymap.set("n", "<leader>bx", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  if #buffers > 1 then
    -- If there are other buffers available, switch to another buffer first
    vim.cmd("bnext") -- Go to the next buffer
    vim.cmd("bdelete " .. current_buf) -- Delete the previous buffer
  else
    -- If this is the last buffer, just delete it (and close the window)
    vim.cmd("bdelete!")
  end
end, { desc = "[B]uffer e[X]it (preserve split)" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts_with_desc("[S]plit [V]ertically"))
vim.keymap.set("n", "<leader>sh", "<C-w>s", opts_with_desc("[S]plit [H]orizontally"))
vim.keymap.set("n", "<leader>se", "<C-w>=", opts_with_desc("[S]plits [E]qual"))
vim.keymap.set("n", "<leader>sm", "<C-w>|<C-w>_", opts_with_desc("[S]plit [M]aximize"))
vim.keymap.set("n", "<leader>sx", "<C-w>q", opts_with_desc("[S]plit e[X]it"))

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts_with_desc("[T]ab [O]pen"))
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts_with_desc("[T]ab e[X]it"))
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts_with_desc("[T]ab [N]ew"))
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts_with_desc("[T]ab [P]revious"))

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts_with_desc("[L]ine [W]rap"))

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
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating [D]iagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- CMake
vim.keymap.set("", "<leader>cg", ":CMakeGenerate<CR>", opts_with_desc("[C]Make [G]enerate"))
vim.keymap.set("", "<leader>cb", ":CMakeBuild<CR>", opts_with_desc("[C]Make [B]uild"))
vim.keymap.set("", "<leader>cq", ":CMakeClose<CR>", opts_with_desc("[C]Make [C]lose"))
vim.keymap.set("", "<leader>cc", ":CMakeClean<CR>", opts_with_desc("[C]Make [C]lean"))
