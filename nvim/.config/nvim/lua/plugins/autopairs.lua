return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  -- Optional dependency
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    local npairs = require("nvim-autopairs")
    local nrule = require("nvim-autopairs.rule")
    local ncond = require("nvim-autopairs.conds")
    npairs.setup({})
    npairs.add_rule(nrule("<", ">", { "rust", "cpp" }):with_pair(ncond.not_before_regex_check(" ")))
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
