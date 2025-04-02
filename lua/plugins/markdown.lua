return {
  {
    'OXY2DEV/markview.nvim',
    dependencies = {
      'echasnovski/mini.icons',
    },
    priority = 500,
    lazy = false,
    opts = {
      preview = {
        icon_provider = 'mini',
      },
    },
    keys = {
      { '<leader>tm', function() vim.cmd.Markview 'toggle' end, desc = '[M]arkdown Render' },
    },
  },
}
