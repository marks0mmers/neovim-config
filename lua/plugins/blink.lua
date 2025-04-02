return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    {
      'xzbdmw/colorful-menu.nvim',
      opts = {
        ls = {
          vtsls = {
            extra_info_hl = '@comment',
          },
        },
      },
    },
  },
  version = '*',
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        window = { border = 'rounded' },
      },
      menu = {
        border = 'rounded',
        draw = {
          columns = { { 'label', 'kind_icon', 'label_description', gap = 1 }, { 'kind' } },
          components = {
            label = {
              text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
              highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
            },
            kind_icon = {
              text = function(item)
                local kind = require('lspkind').symbol_map[item.kind] or ''
                return kind
              end,
              highlight = 'CmpItemKind',
            },
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
    },
  },
  opts_extend = { 'sources.default', 'sources.completion.enabled_providers' },
}
