return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
    { 'saghen/blink.compat', lazy = true, version = false },
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
          columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require('lspkind').symbol_map[item.kind] or ''
                return kind .. ' '
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
      default = { 'lsp', 'path', 'snippets', 'buffer', 'obsidian', 'obsidian_new', 'obsidian_tags' },
      providers = {
        obsidian = {
          name = 'obsidian',
          module = 'blink.compat.source',
        },
        obsidian_new = {
          name = 'obsidian_new',
          module = 'blink.compat.source',
        },
        obsidian_tags = {
          name = 'obsidian_tags',
          module = 'blink.compat.source',
        },
      },
    },
  },
  opts_extend = { 'sources.default', 'sources.completion.enabled_providers' },
}
