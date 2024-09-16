require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "clangd", "jsonls", "ts_ls" },
})

mason_lspconfig.setup_handlers({
  function(server_name)
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    }
    -- Setup config tables
    local default_config = {
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

local augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { ctermbg = 237, bg = "#45403d" })
      vim.api.nvim_set_hl(0, "LspReferenceText", { ctermbg = 237, bg = "#45403d" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { ctermbg = 237, bg = "#45403d" })
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
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
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
    vim.keymap.set("n", "<Leader>cD", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Show type definition" })
    vim.keymap.set("n", "<Leader>cn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Show code actions" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Show references" })

    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      buffer = ev.buf,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          source = "always",
          prefix = " ",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
})
