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
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
