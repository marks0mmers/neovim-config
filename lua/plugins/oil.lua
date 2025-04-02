return {
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    keys = {
      { '<leader>e', vim.cmd.Oil, desc = '[E]xplorer' },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      win_options = {
        signcolumn = 'yes:2',
      },
    },
  },
  {
    'refractalize/oil-git-status.nvim',
    ft = 'oil',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
