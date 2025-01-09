return {
  {
    'alexghergh/nvim-tmux-navigation',
    opts = {
      disable_when_zoomed = true,
      keybindings = {
        left = '<C-w><C-h>',
        down = '<C-w><C-j>',
        up = '<C-w><C-k>',
        right = '<C-w><C-l>',
        last_active = '<C-w><C-\\>',
        next = '<C-w><C-Space>',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    build = function()
      if not require('lazy.core.config').spec.plugins['mason.nvim'] then
        vim.print('Installing go dependencies...')
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'williamboman/mason.nvim', optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
  },
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  { 'echasnovski/mini.surround' },
  { 'echasnovski/mini.comment', opts = {} },
  {
    'echasnovski/mini.statusline',
    opts = { use_icons = vim.g.have_nerd_font },
  },
  {
    'vuki656/package-info.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {},
  },
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>sj', '<cmd>TSJJoin<CR>', desc = '[J]oin' },
      { '<leader>ss', '<cmd>TSJSplit<CR>', desc = '[S]plit' },
      { '<leader>st', '<cmd>TSJToggle<CR>', desc = '[T]oggle' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    opts = { use_default_keymaps = false },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = '[T]oggle [U]ndotree ' },
    },
  },
}
