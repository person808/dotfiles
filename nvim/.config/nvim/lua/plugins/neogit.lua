require("neogit").setup({
  kind = "split",
  commit_select_view = {
    kind = "split",
  },
  log_view = {
    kind = "split",
  },
  reflog_view = {
    kind = "split",
  },
})

vim.keymap.set("n", "<leader>gs", function()
  require("neogit").open()
end, { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", function()
  require("neogit").open({ "commit" })
end, { desc = "Git commit" })
vim.keymap.set("n", "<leader>gl", function()
  require("neogit").open({ "log" })
end, { desc = "Git log" })
