return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  "airblade/vim-rooter",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  "haya14busa/is.vim",
  "lewis6991/satellite.nvim",
  "rhysd/clever-f.vim",
  "tpope/vim-eunuch",
  "windwp/nvim-ts-autotag",
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    -- Load before nvim-treesitter (default priority is 50)
    priority = 40,
    dependencies = {
      "saghen/blink.cmp",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSInstall all",
    lazy = false,
    config = function()
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
    end,
  },
}
