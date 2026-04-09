return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      setopt = true,
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        {
          sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa",
        },
      },
    })

    vim.o.foldcolumn = "1"
  end,
}
