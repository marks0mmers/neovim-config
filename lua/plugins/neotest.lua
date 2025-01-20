return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-plenary',
      'marilari88/neotest-vitest',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    keys = {
      { '<leader>tt', '<cmd>Neotest run<CR>', desc = '[T]est' },
    },
    opts = function()
      return {
        adapters = {
          require('neotest-go'),
          require('neotest-vitest'),
          require('neotest-plenary'),
        },
      }
    end,
  },
}
