require("dressing").setup({
  input = {
    border = "solid",
    win_options = {
      winblend = require("ui").floating_window_options.winblend,
    },
  },
  select = {
    backend = { "builtin" },
    builtin = {
      relative = "cursor",
      border = "solid",
      win_options = {
        winblend = require("ui").floating_window_options.winblend,
        winhighlight = "CursorLine:PmenuSel",
      },
    },
  },
})
