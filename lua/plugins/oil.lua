return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      win_options = {
        signcolumn = 'yes:2',
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
