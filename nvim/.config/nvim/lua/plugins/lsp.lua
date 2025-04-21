return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  "onsails/lspkind.nvim",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local mason_registry = require("mason-registry")
      local packages = {
        "basedpyright",
        "bash-language-server",
        "clangd",
        "cmake-language-server",
        "json-lsp",
        "lua-language-server",
        "shellcheck",
        "stylua",
        "typescript-language-server",
      }

      mason_registry.refresh(function()
        for _, pkg_name in ipairs(packages) do
          local pkg = mason_registry.get_package(pkg_name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          -- Setup config tables
          local server_configs = {
            lua_ls = {
              settings = {
                Lua = {
                  workspace = {
                    checkThirdParty = false,
                  },
                },
              },
            },
          }

          vim.lsp.config(server_name, server_configs[server_name] or {})
          vim.lsp.enable(server_name)
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end

          if client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = "expr"
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
          end

          if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", {
              clear = false,
            })
            vim.api.nvim_clear_autocmds({
              buffer = bufnr,
              group = "lsp_document_highlight",
            })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = "lsp_document_highlight",
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = "lsp_document_highlight",
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable()
          end

          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { buffer = bufnr, desc = "Go to declaration" }
          )
          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { buffer = bufnr, desc = "Go to definition" }
          )
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            { buffer = bufnr, desc = "Go to implementation" }
          )
          -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set(
            "n",
            "<Leader>cwa",
            vim.lsp.buf.add_workspace_folder,
            { buffer = bufnr, desc = "Add workspace folder" }
          )
          vim.keymap.set(
            "n",
            "<Leader>cwr",
            vim.lsp.buf.remove_workspace_folder,
            { buffer = bufnr, desc = "Remove workspace folder" }
          )
          vim.keymap.set("n", "<Leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = bufnr, desc = "Show workspace folders" })
          vim.keymap.set(
            "n",
            "<Leader>cD",
            vim.lsp.buf.type_definition,
            { buffer = bufnr, desc = "Show type definition" }
          )
          vim.keymap.set("n", "<Leader>cn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          vim.keymap.set(
            { "n", "v" },
            "<Leader>ca",
            vim.lsp.buf.code_action,
            { buffer = bufnr, desc = "Show code actions" }
          )
          vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            { buffer = bufnr, desc = "Show references" }
          )
        end,
      })
    end,
  },
}
