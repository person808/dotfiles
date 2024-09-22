vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.g.mapleader = " "

vim.g.clever_f_smart_case = true
vim.g.clever_f_fix_key_direction = true
vim.g.rooter_resolve_links = true

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<leader>cx", vim.diagnostic.setqflist, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>cX", vim.diagnostic.setloclist, { desc = "Buffer Diagnostics" })

-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("JumpToLastPosition", {}),
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "commit"

    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "solid",
  },
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("diagnostic_hover", {}),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      prefix = " ",
      scope = "cursor",
    }
    local _, win_id = vim.diagnostic.open_float(nil, opts)
    if win_id then
      require("ui").set_float_options(win_id)
    end
  end,
})

do
  -- Specifies where to install/use rocks.nvim
  local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")
  -- Set up configuration options related to rocks.nvim (recommended to leave as default)
  local rocks_config = {
    rocks_path = vim.fs.normalize(install_location),
  }
  vim.g.rocks_nvim = rocks_config

  -- Configure the package path (so that plugin code can be found)
  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  -- Configure the C path (so that e.g. tree-sitter parsers can be found)
  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  -- Load all installed plugins, including rocks.nvim itself
  vim.opt.runtimepath:append(
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*")
  )
end

-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
  local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")
  if not vim.uv.fs_stat(rocks_location) then
    -- Pull down rocks.nvim
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/nvim-neorocks/rocks.nvim",
      rocks_location,
    })
  end

  -- If the clone was successful then source the bootstrapping script
  assert(
    vim.v.shell_error == 0,
    "rocks.nvim installation failed. Try exiting and re-entering Neovim!"
  )
  vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))
  vim.fn.delete(rocks_location, "rf")
end

vim.cmd.colorscheme("ayu-mirage")

local colors = require("ayu.colors")
colors.generate(false)
vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.panel_bg })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "FloatTitle", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.fg, bg = colors.selection_bg })
vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = colors.fg, bg = colors.panel_border })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "TelescopePromptNormal" })
vim.api.nvim_set_hl(
  0,
  "TelescopePromptTitle",
  { fg = colors.panel_border, bg = colors.panel_border }
)
vim.api.nvim_set_hl(
  0,
  "TelescopePreviewNormal",
  { fg = colors.panel_shadow, bg = colors.panel_shadow }
)
vim.api.nvim_set_hl(
  0,
  "TelescopePreviewBorder",
  { fg = colors.panel_shadow, bg = colors.panel_shadow }
)
vim.api.nvim_set_hl(
  0,
  "TelescopePreviewTitle",
  { fg = colors.panel_shadow, bg = colors.panel_shadow }
)
vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "PmenuSel" })
vim.api.nvim_set_hl(0, "TelescopeMultiSelection", { fg = colors.entity })
vim.api.nvim_set_hl(0, "TelescopeMultiIcon", { fg = colors.entity })
vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "WhichKeyTitle", { link = "NormalFloat" })
