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
      { 'lawrence-laz/neotest-zig', version = '1.3.*' },
    },
    opts = function()
      return {
        adapters = {
          require('neotest-go'),
          require('neotest-vitest'),
          require('neotest-plenary'),
          require('neotest-zig')({
            dap = {
              adapter = 'lldb',
            },
          }),
        },
      }
    end,
  },
}
