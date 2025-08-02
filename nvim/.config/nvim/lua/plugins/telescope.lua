return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope_config = require("telescope.config")
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          entry_prefix = " ",
          multi_icon = "",
          results_title = false,
          prompt_title = false,
          preview_title = false,
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          border = true,
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          winblend = require("ui").floating_window_options.winblend,
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          builtin = {
            previewer = false,
          },
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      local function find_files_from_project_git_root()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          return vim.v.shell_error == 0
        end
        local function get_git_root()
          local dot_git_path = vim.fn.finddir(".git", ".;")
          return vim.fn.fnamemodify(dot_git_path, ":h")
        end
        local opts = { hidden = true }
        if is_git_repo() then
          vim.tbl_extend("force", opts, { cwd = get_git_root() })
        end
        require("telescope.builtin").find_files(opts)
      end

      vim.keymap.set("n", "<leader><leader>", function()
        require("telescope.builtin").builtin()
      end, { desc = "Telecope pickers" })
      vim.keymap.set("n", "<leader>ff", find_files_from_project_git_root, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fs", function()
        require("telescope.builtin").live_grep()
      end, { desc = "Search" })
      vim.keymap.set("n", "<leader>bb", function()
        require("telescope.builtin").buffers()
      end, { desc = "Show buffers" })
    end,
  },
}
