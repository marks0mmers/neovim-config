return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      { 'mfussenegger/nvim-jdtls' },
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      format_on_save = {},
      formatters_by_ft = {
        lua = { 'stylua' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        markdown = { 'markdown-toc', 'prettier' },
        json = { 'prettier' },
        scss = { 'prettier' },
        go = { 'gofumpt', 'goimports', 'golines' },
        rust = { 'rustfmt' },
      },
    },
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    build = function() vim.cmd.GoInstallDeps() end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json',
    opts = {},
  },
}
