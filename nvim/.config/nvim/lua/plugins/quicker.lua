return {
  {
    "stevearc/quicker.nvim",
    config = function()
      require("quicker").setup()
      vim.keymap.set("n", "<leader>wQ", function()
        require("quicker").toggle()
      end, { desc = "Toggle Quickfix List" })
      vim.keymap.set("n", "<leader>wL", function()
        require("quicker").toggle({ loclist = true })
      end, { desc = "Toggle Location List" })
    end,
  },
}
