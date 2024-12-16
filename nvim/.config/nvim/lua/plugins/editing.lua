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
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
