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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Ensure markview loads first to install treesitter queries
    dependencies = { "OXY2DEV/markview.nvim" },
    config = function()
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp"
    },
  },
}
