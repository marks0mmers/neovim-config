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
    config = function()
      local neotest = require('neotest')
      neotest.setup({
        adapters = {
          require('neotest-go'),
          require('neotest-vitest'),
          require('neotest-plenary'),
        },
      })

      vim.keymap.set('n', '<leader>tc', function()
        neotest.run.run()
      end)
    end,
  },
}
