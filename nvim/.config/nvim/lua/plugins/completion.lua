return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        trigger = { show_in_snippet = false },
        documentation = {
          auto_show = true,
          window = {
            winblend = require("ui").floating_window_options.winblend,
          },
        },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
          winblend = require("ui").floating_window_options.winblend,
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = {
        enabled = true,
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  "xzbdmw/colorful-menu.nvim",
}
