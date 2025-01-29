return {
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    ft = 'markdown',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = 'main',
          path = '~/vaults/notes',
        },
      },
      completions = {
        nvim_cmp = true,
      },
      mappings = {
        ['<leader>nc'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = 'Toggle [C]heckbox' },
        },
        ['<leader>no'] = {
          action = '<cmd>ObsidianOpen<CR>',
          opts = { buffer = true, desc = '[O]pen in Obsidian' },
        },
        ['<cr>'] = {
          action = function()
            return require('obsidian').util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
    },
  },
  {
    'OXY2DEV/markview.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    priority = 500,
    lazy = false,
    opts = {},
    init = function()
      vim.keymap.set('n', '<leader>tm', '<cmd>Markview toggle<CR>', { desc = '[M]arkdown Render' })
    end,
  },
}
