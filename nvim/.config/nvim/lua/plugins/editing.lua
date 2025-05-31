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
    branch = "main",
    build = ":TSUpdate",
    -- Ensure markview loads first to install treesitter queries
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    config = function()
      require("nvim-treesitter").install("stable")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = args.match
          if
            pcall(function()
              vim.treesitter.get_parser(args.buf, filetype)
            end)
          then
            vim.treesitter.start(args.buf, vim.treesitter.language.get_lang(filetype))
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp",
    },
  },
}
