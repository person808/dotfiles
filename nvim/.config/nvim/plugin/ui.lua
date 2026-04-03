vim.cmd("colorscheme jb")

vim.keymap.set("n", "H", ":BufferPrevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "L", ":BufferNext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bc", ":BufferClose<CR>", { silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>bc", ":BufferClose<CR>", { silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>bC", ":BufferRestore<CR>", { silent = true, desc = "Restore buffer" })

require("dressing").setup({
  select = {
    backend = { "builtin" },
    builtin = {
      relative = "cursor",
    },
  },
})

require("fidget").setup({
  notification = {
    override_vim_notify = true,
    window = {
      winblend = 0,
    },
  },
})

require("colorizer").setup()

require("ibl").setup({
  scope = { enabled = false },
  exclude = { filetypes = { "markdown" } },
})

require("lualine").setup({
  options = {
    theme = "jb",
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
      {
        "diagnostics",
        symbols = { error = "● ", warn = "● ", hint = "● ", info = "● " },
      },
    },
  },
  extensions = { "lazy", "oil", "quickfix" },
})

local statuscol_builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true,
  segments = {
    {
      sign = { namespace = { "diagnostic/sign" }, maxwidth = 1 },
      click = "v:lua.ScSa",
    },
    {
      text = { statuscol_builtin.lnumfunc, " " },
      click = "v:lua.ScLa",
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
        maxwidth = 1,
        colwidth = 1,
      },
      click = "v:lua.ScSa",
    },
    {
      text = { statuscol_builtin.foldfunc, " " },
      click = "v:lua.ScFa",
    },
  },
})

require("which-key").setup({
  preset = "helix",
  win = {
    col = 0,
  },
  spec = {
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Code" },
    { "<leader>cw", group = "Workspace" },
    { "<leader>f", group = "Files" },
    { "<leader>g", group = "Git" },
    { "<leader>gh", group = "Hunks" },
    { "<leader>w", group = "Windows" },
  },
})
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })

require("quicker").setup()
vim.keymap.set("n", "<leader>wQ", function()
  require("quicker").toggle()
end, { desc = "Toggle Quickfix List" })
vim.keymap.set("n", "<leader>wL", function()
  require("quicker").toggle({ loclist = true })
end, { desc = "Toggle Location List" })

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
