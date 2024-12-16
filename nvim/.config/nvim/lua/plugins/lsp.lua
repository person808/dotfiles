local ui = require("ui")

local float_namespace = vim.api.nvim_create_namespace("lsp_float")
--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
  for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    for pattern, hl_group in pairs({
      ["@%S+"] = "@parameter",
      ["^%s*(Parameters:)"] = "@text.title",
      ["^%s*(Return:)"] = "@text.title",
      ["^%s*(See also:)"] = "@text.title",
      ["{%S-}"] = "@parameter",
      ["|%S-|"] = "@text.reference",
    }) do
      local from = 1 ---@type integer?
      while from do
        local to
        from, to = line:find(pattern, from)
        if from then
          vim.api.nvim_buf_set_extmark(buf, float_namespace, l - 1, from - 1, {
            end_col = to,
            hl_group = hl_group,
          })
        end
        from = to and to + 1 or nil
      end
    end
  end
end

--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
  contents = vim.lsp.util._normalize_markdown(contents, {
    width = vim.lsp.util._make_floating_popup_size(contents, opts),
  })
  vim.bo[bufnr].filetype = "markdown"
  vim.treesitter.start(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

  add_inline_highlights(bufnr)

  return contents
end

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
          local handlers = {
            ["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover,
              { border = ui.floating_window_options.border }
            ),
            ["textDocument/signatureHelp"] = vim.lsp.with(
              vim.lsp.handlers.signature_help,
              { border = ui.floating_window_options.border }
            ),
          }
          -- Setup config tables
          local default_config = {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
            handlers = handlers,
          }
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

          require("lspconfig")[server_name].setup(
            vim.tbl_deep_extend("force", default_config, server_configs[server_name] or {})
          )
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

          vim.o.foldmethod = "expr"
          vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"

          if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end
          if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
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

          local opts = { buffer = bufnr }
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
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
