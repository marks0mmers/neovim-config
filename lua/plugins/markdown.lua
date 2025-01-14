return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
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
          action = function() return require('obsidian').util.toggle_checkbox() end,
          opts = { buffer = true, desc = 'Toggle [C]heckbox' },
        },
        ['<leader>no'] = {
          action = '<cmd>ObsidianOpen<CR>',
          opts = { buffer = true, desc = '[O]pen in Obsidian' },
        },
        ['<cr>'] = {
          action = function() return require('obsidian').util.smart_action() end,
          opts = { buffer = true, expr = true },
        },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      anti_conceal = {
        ignore = {
          link = true,
        },
      },
    },
    init = function() vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', { desc = '[M]arkdown Render' }) end,
  },
}
