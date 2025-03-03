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
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
