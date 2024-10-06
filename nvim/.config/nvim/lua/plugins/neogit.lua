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

local autocmd_group = vim.api.nvim_create_augroup("NeogitAutocmds", { clear = true })
vim.api.nvim_create_autocmd({ "Filetype" }, {
  group = autocmd_group,
  pattern = { "Neogit*" },
  callback = function()
    vim.wo.foldcolumn = "0"
  end,
})
