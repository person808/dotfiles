require("gitsigns").setup({
  preview_config = {
    border = "solid",
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous hunk" })

    -- Actions
    map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>ghs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage selected hunk" })
    map("v", "<leader>ghr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset selected hunk" })
    map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
  end,
})
