return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("notify").setup({
      timeout = 2000,
    })
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        -- { filter = { event = "msg_showmode" }, view = "notify" },
        { filter = { find = "E162" }, view = "mini" },
        { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
        { filter = { event = "msg_show", kind = "", find = "fewer" }, view = "mini" },
        { filter = { event = "msg_show", kind = "", find = "<ed" }, view = "mini" },
        { filter = { event = "msg_show", kind = "", find = ">ed" }, view = "mini" },
        { filter = { event = "msg_show", find = "search hit BOTTOM" }, skip = true },
        { filter = { event = "msg_show", find = "search hit TOP" }, skip = true },
        { filter = { event = "emsg", find = "E23" }, skip = true },
        { filter = { event = "emsg", find = "E20" }, skip = true },
        { filter = { find = "No signature help" }, skip = true },
        { filter = { find = "E37" }, skip = true },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })
  end,
}
