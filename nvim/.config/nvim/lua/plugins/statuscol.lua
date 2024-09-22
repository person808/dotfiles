local builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true,
  segments = {
    {
      sign = { namespace = { "diagnostic/sign" }, maxwidth = 1 },
      click = "v:lua.ScSa",
    },
    {
      text = { builtin.lnumfunc, " " },
      click = "v:lua.ScLa",
    },
    {
      text = { builtin.foldfunc, " " },
      click = "v:lua.ScFa",
    },
    {
      sign = {
        name = { ".*" },
        maxwidth = 1,
        colwidth = 1,
        wrap = true,
      },
      click = "v:lua.ScSa",
    },
    {
      sign = {
        namespace = { "gitsigns" },
        maxwidth = 2,
        colwidth = 1,
        auto = true,
        wrap = true,
      },
      click = "v:lua.ScSa",
    },
    { text = { " " } },
  },
})
