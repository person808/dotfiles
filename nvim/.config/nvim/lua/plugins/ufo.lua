require("ufo").setup({
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
})
vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
