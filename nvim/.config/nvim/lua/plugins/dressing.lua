require("dressing").setup({
  input = {
    border = require("ui").floating_window_options.border
  },
  select = {
    backend = { "builtin" },
    builtin = {
      relative = "cursor",
      border = require("ui").floating_window_options.border,
    },
  },
})
