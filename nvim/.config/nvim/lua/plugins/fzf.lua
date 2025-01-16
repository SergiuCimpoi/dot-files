return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble
    config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

    return {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.filename_first",
      },
      -- Custom LazyVim option to configure vim.ui.select
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      files = {
        no_header_i = true,
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        no_header_i = true,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  keys = {
    -- { "<c-j>", "<Down>", ft = "fzf", mode = "t", nowait = true },
    -- { "<c-k>", "<Up>", ft = "fzf", mode = "t", nowait = true },
    {
      "<leader>,",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "[F]ind by [G]rep" },
    { "<leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    -- git
    { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "[G]it [F]iles" },
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "[G]it [C]ommits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "[G]it [S]tatus" },
    -- find
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "[F]ind [F]iles" },
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "[F]ind [B]uffers" },
    { "<leader>f.", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<leader>f\"", "<cmd>FzfLua registers<cr>", desc = "[F]ind [R]egisters" },
    { "<leader>fa", "<cmd>FzfLua autocmds<cr>", desc = "[F]ind [A]uto Commands" },
    { "<leader>fB", "<cmd>FzfLua grep_curbuf<cr>", desc = "[F]ind in [B]uffer" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "[F]ind [C]ommands" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "[F]ind [D]ocument Diagnostics" },
    { "<leader>fw", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "[F]ind [W]orkspace Diagnostics" },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "[F]ind [H]elp" },
    { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "[F]ind [H]ighlight Groups" },
    { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "[F]ind [J]umplist" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "[F]ind [K]ey Maps" },
    { "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "[F]ind [L]ocation List" },
    { "<leader>fM", "<cmd>FzfLua man_pages<cr>", desc = "[F]ind [M]an Pages" },
    { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "[F]ind [M]ark" },
    { "<leader>fR", "<cmd>FzfLua resume<cr>", desc = "[F]ind [R]esume" },
    { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "[F]ind [Q]uickfix List" },
    { "<leader>fC", "<cmd>FzfLua colorschemes<cr>", desc = "[F]ind [C]olorscheme with Preview" },
    {
      "<leader>ft",
      function()
        require("fzf-lua").grep({ search = "TODO:|HACK:|PERF:|NOTE:|FIX:", no_esc = true })
      end,
      desc = "[F]ind [T]ODOs",
    },
  },
}
