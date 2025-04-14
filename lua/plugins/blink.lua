return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    'xzbdmw/colorful-menu.nvim',
  },
  version = '*',
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          columns = {
            { 'label', 'kind_icon', 'label_description', gap = 1 },
            { 'kind' },
          },
          components = {
            label = {
              text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
              highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
            },
            kind_icon = {
              text = function(item) return require('lspkind').symbol_map[item.kind] or '' end,
              highlight = 'CmpItemKind',
            },
          },
        },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
