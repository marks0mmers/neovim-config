return {
  { 'nmac427/guess-indent.nvim', opts = {} },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
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
