local function github(repository)
  return "https://github.com/" .. repository
end

--- @alias PackEventKind 'install' | 'update' | 'delete'
--- @type table<string, table<PackEventKind, function>>
local pack_event_handlers = {
  ["nvim-treesitter"] = {
    install = function()
      vim.cmd("TSInstall all")
    end,
    update = function()
      vim.cmd("TSUpdate")
    end,
  },
}

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    --- @type string, string
    local name, kind = ev.data.spec.name, ev.data.kind
    local event_handler = pack_event_handlers[name] and pack_event_handlers[name][kind]
    if event_handler ~= nil then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end
      event_handler()
    end
  end,
})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update packages" })

vim.api.nvim_create_user_command("PackDelete", function()
  local inactive_plugins = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()

  vim.pack.del(inactive_plugins)
end, { desc = "Delete packages" })

vim.pack.add({
  -- Misc
  github("nvim-lua/plenary.nvim"),
  github("pocco81/auto-save.nvim"),
  github("airblade/vim-rooter"),
  github("tpope/vim-sleuth"),
  github("tpope/vim-surround"),
  github("haya14busa/is.vim"),
  github("rhysd/clever-f.vim"),
  github("tpope/vim-eunuch"),
  github("windwp/nvim-ts-autotag"),
  github("OXY2DEV/markview.nvim"),
  github("nvim-treesitter/nvim-treesitter"),
  github("JoosepAlviste/nvim-ts-context-commentstring"),

  -- UI
  github("stevearc/oil.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("nickkadutskyi/jb.nvim"),
  github("romgrk/barbar.nvim"),
  github("catgoose/nvim-colorizer.lua"),
  github("lewis6991/satellite.nvim"),
  github("folke/which-key.nvim"),
  github("stevearc/dressing.nvim"),
  github("j-hui/fidget.nvim"),
  github("lukas-reineke/indent-blankline.nvim"),
  github("nvim-lualine/lualine.nvim"),
  github("stevearc/quicker.nvim"),
  github("luukvbaal/statuscol.nvim"),
  github("nvim-telescope/telescope.nvim"),

  -- LSP
  github("folke/lazydev.nvim"),
  github("onsails/lspkind.nvim"),
  github("williamboman/mason.nvim"),
  github("williamboman/mason-lspconfig.nvim"),
  github("neovim/nvim-lspconfig"),

  -- Completion
  { src = github("saghen/blink.cmp"), version = vim.version.range("1.x") },
  github("rafamadriz/friendly-snippets"),
  github("xzbdmw/colorful-menu.nvim"),
  github("windwp/nvim-autopairs"),

  -- Formatting/Linting
  github("stevearc/conform.nvim"),
  github("mfussenegger/nvim-lint"),

  -- Git
  github("NeogitOrg/neogit"),
  github("sindrets/diffview.nvim"),
  github("lewis6991/gitsigns.nvim"),
})

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
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.winborder = require("ui").floating_window_options.border
vim.o.pumblend = require("ui").floating_window_options.winblend
vim.g.mapleader = " "
vim.o.background = "light"

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

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
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.HINT] = "●",
      [vim.diagnostic.severity.INFO] = "●",
    },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("diagnostic_hover", {}),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
