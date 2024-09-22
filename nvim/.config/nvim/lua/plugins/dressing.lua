require("dressing").setup({
  input = {
    border = "solid",
  },
  select = {
    backend = { "builtin" },
    builtin = {
      relative = "cursor",
      border = "solid",
      win_options = {
        winhighlight = "CursorLine:PmenuSel",
      },
    },
  },
})
