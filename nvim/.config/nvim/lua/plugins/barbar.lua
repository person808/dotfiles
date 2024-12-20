return {
  {
    "romgrk/barbar.nvim",
    config = function()
      vim.keymap.set("n", "H", ":BufferPrevious<CR>", { silent = true, desc = "Previous buffer" })
      vim.keymap.set("n", "L", ":BufferNext<CR>", { silent = true, desc = "Next buffer" })
      vim.keymap.set(
        "n",
        "<leader>bc",
        ":BufferClose<CR>",
        { silent = true, desc = "Close buffer" }
      )
      vim.keymap.set(
        "n",
        "<leader>bc",
        ":BufferClose<CR>",
        { silent = true, desc = "Close buffer" }
      )
      vim.keymap.set(
        "n",
        "<leader>bC",
        ":BufferRestore<CR>",
        { silent = true, desc = "Restore buffer" }
      )
    end,
  },
}
