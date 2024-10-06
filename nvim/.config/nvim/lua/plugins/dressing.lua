require("dressing").setup({
  input = {
    border = "solid",
  },
  select = {
    backend = { "builtin" },
    builtin = {
      relative = "cursor",
      border = require("ui").floating_window_options.border,
    },
  },
})
