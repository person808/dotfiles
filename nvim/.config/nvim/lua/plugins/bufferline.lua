require("bufferline").setup()
vim.keymap.set("n", "H", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
