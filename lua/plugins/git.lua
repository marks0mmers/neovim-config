return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange', buffer = bufnr })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange', buffer = bufnr })

        vim.keymap.set(
          'v',
          '<leader>ghr',
          function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          { desc = 'reset git hunk', buffer = bufnr }
        )
        vim.keymap.set('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>ghb', gitsigns.blame_line, { desc = 'git [b]lame line', buffer = bufnr })
        vim.keymap.set(
          'n',
          '<leader>tb',
          gitsigns.toggle_current_line_blame,
          { desc = 'git show [b]lame line', buffer = bufnr }
        )
        vim.keymap.set('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'git show [D]eleted', buffer = bufnr })
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gs', vim.cmd.G, desc = '[S]tatus' },
      { '<leader>gp', function() vim.cmd.G 'pull' end, desc = '[P]ull' },
      { '<leader>gds', function() vim.cmd.Gvdiffsplit { bang = true } end, desc = '[D]iff [S]plit' },
      { '<leader>gdl', function() vim.cmd.diffget '//2' end, desc = '[D]iff [L]eft' },
      { '<leader>gdr', function() vim.cmd.diffget '//3' end, desc = '[D]iff [R]ight' },
    },
  },
  {
    'radar',
    event = 'VeryLazy',
    dir = '~/Developer/Work/m-sommers/nvim-radar',
    dev = true,
    enabled = function() return vim.fn.isdirectory(vim.fs.abspath '~/Developer/Work/m-sommers/nvim-radar') == 1 end,
    opts = {
      dsid = 2702080918,
      board = 'Team - Production Development',
    },
  },
}
