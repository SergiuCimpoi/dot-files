return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    vim.keymap.set({ "n", "x" }, "<leader>q", mc.toggleCursor, { desc = "Toggle multicursor" })

    vim.keymap.set({ "n", "x" }, "<M-k>", function()
      mc.lineAddCursor(-1)
    end, { desc = "Add cursor up" })
    vim.keymap.set({ "n", "x" }, "<M-j>", function()
      mc.lineAddCursor(1)
    end, { desc = "Add cursor down" })

    set({ "n", "x" }, "<M-K>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "x" }, "<M-J>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip cursor above/below
    -- set({ "n", "x" }, "<up>", function()
    --   mc.lineAddCursor(-1)
    -- end)
    -- set({ "n", "x" }, "<down>", function()
    --   mc.lineAddCursor(1)
    -- end)
    -- set({ "n", "x" }, "<leader><up>", function()
    --   mc.lineSkipCursor(-1)
    -- end)
    -- set({ "n", "x" }, "<leader><down>", function()
    --   mc.lineSkipCursor(1)
    -- end)

    -- Add/skip cursors by matching word/selection
    set({ "n", "x" }, "<leader>n", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "x" }, "<leader>s", function()
      mc.matchSkipCursor(1)
    end)
    set({ "n", "x" }, "<leader>N", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "x" }, "<leader>S", function()
      mc.matchSkipCursor(-1)
    end)

    -- Mouse support for adding/removing cursors
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Toggle cursors
    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- Cursor navigation and deletion (active only when multiple cursors enabled)
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize cursor highlights
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
  end,
}
