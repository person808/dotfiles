vim.g.clever_f_smart_case = true
vim.g.clever_f_fix_key_direction = true
vim.g.rooter_resolve_links = true
vim.g.rooter_silent_chdir = true

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- Try to start treesitter
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("auto-save").setup({
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")

    if
      fn.getbufvar(buf, "&modifiable") == 1
      and utils.not_in(fn.getbufvar(buf, "&filetype"), { "oil", "gitcommit" })
    then
      return true -- met condition(s), can save
    end
    return false -- can't save
  end,
})
