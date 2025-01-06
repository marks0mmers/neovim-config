-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter-context',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'go',
        'gomod',
        'html',
        'java',
        'javascript',
        'jsdoc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'odin',
        'query',
        'rust',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- don't know why you have to do this
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {
      -- this shit is backwards lol
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    },
  },
}
