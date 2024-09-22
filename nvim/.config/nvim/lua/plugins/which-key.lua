require("which-key").setup({
  preset = "helix",
  win = {
    col = 0,
    border = "solid",
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
