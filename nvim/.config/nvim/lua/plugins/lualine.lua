require("lualine").setup({
  options = {
    theme = "ayu",
    section_separators = "",
    component_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = {
      "branch",
      "diff",
    },
    lualine_c = {
      { "diagnostics", symbols = { error = "● ", warn = "● ", hint = "● ", info = "● " } },
    },
  },
  extensions = { "lazy", "oil", "quickfix" },
})
