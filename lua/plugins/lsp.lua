return {
  {
    'nvim-java/nvim-java',
    opts = {
      root_markers = {
        'mvnw',
        'gradlew',
        '.git',
      },
    },
  },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    --- @module 'lazydev'
    --- @type lazydev.Config
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
