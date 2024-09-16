require("telescope").setup({
  defaults = require("telescope.themes").get_dropdown({}),
  pickers = {
    builtin = {
      previewer = false,
    },
  },
})

vim.keymap.set("n", "<leader><leader>", function()
  require("telescope.builtin").builtin()
end, { desc = "Telecope pickers" })
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Search" })
vim.keymap.set("n", "<leader>bb", function()
  require("telescope.builtin").buffers()
end, { desc = "Show buffers" })
