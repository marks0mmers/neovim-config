return {
  { 'nmac427/guess-indent.nvim', opts = {} },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    build = function() vim.cmd.GoInstallDeps() end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json',
    opts = {},
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
    keys = {
      { '<leader>st', vim.cmd.TSJToggle, desc = '[T]oggle' },
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>tu', vim.cmd.UndotreeToggle, desc = '[U]ndotree ' },
    },
  },
}
