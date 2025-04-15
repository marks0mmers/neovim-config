return {
  { 'brenoprata10/nvim-highlight-colors', opts = {} },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          '>',
          function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end,
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
    opts = function() vim.cmd.colorscheme 'tokyonight-night' end,
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
}
