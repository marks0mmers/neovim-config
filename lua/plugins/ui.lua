return {
  'brenoprata10/nvim-highlight-colors',
  { 'stevearc/dressing.nvim', opts = {} },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          '>',
          function()
            require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = 'Expand quickfix content',
        },
        {
          '<',
          function()
            require('quicker').collapse()
          end,
          desc = 'Collapse quickfix content',
        },
      },
    },
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
  {
    'folke/snacks.nvim',
    priority = 1000,
    opts = {
      notifier = {},
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
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
}
