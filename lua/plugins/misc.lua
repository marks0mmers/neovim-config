return {
  { 'nmac427/guess-indent.nvim', opts = {} },
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
      { 'williamboman/mason.nvim', optional = true },
    },
    opts = {},
  },
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  { 'echasnovski/mini.comment', opts = {} },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
    keys = {
      { '<leader>sj', '<cmd>TSJJoin<CR>', desc = '[J]oin' },
      { '<leader>ss', '<cmd>TSJSplit<CR>', desc = '[S]plit' },
      { '<leader>st', '<cmd>TSJToggle<CR>', desc = '[T]oggle' },
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = '[T]oggle [U]ndotree ' },
    },
  },
}
