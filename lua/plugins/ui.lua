return {
  'brenoprata10/nvim-highlight-colors',
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          '>',
          function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end,
          desc = 'Expand quickfix content',
        },
        {
          '<',
          function() require('quicker').collapse() end,
          desc = 'Collapse quickfix content',
        },
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = function() vim.cmd.colorscheme('tokyonight-night') end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module "todo-comments"
    ---@type TodoOptions
    opts = {
      signs = false,
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      indent = {},
      input = {},
      notifier = {},
      statuscolumn = {},
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
      preset = 'modern',
      spec = {
        { '<leader>l', group = '[L]SP' },
        { '<leader>x', group = '[X]plain Trouble' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>n', group = '[N]otes' },
        { '<leader>m', group = '[M]arks' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>t', group = '[T]oggle/[T]est' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]plit' },
        { '<leader>gh', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>gd', group = 'Git [D]iff' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle focus=true<cr>',
        desc = 'Diagnostics',
      },
    },
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    opts = function()
      vim.keymap.set('n', '<leader>tl', function()
        require('lsp_lines').toggle()
        vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
      end, { desc = '[L]SP Lines' })
    end,
  },
}
