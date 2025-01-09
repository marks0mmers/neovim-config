return {
  'tpope/vim-sleuth',
  'brenoprata10/nvim-highlight-colors',
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
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  { 'echasnovski/mini.surround' },
  { 'echasnovski/mini.comment', opts = {} },
  {
    'echasnovski/mini.statusline',
    opts = { use_icons = vim.g.have_nerd_font },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    opts = {
      notifier = {},
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = function()
      require('which-key').add({
        { '<leader>l', group = '[L]SP' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>t', group = '[T]est/Toggle' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]plit' },
        { '<leader>gh', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>gd', group = 'Git [D]iff' },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
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
