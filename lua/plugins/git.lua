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

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        map('v', '<leader>ghr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>ghb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = 'git show [D]eleted' })
      end,
    },
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
    keys = {
      { '<leader>gs', '<cmd>G<CR>', desc = '[S]tatus' },
      { '<leader>gp', '<cmd>G pull<CR>', desc = '[P]ull' },
      { '<leader>gds', '<cmd>Gvdiffsplit!<CR>', desc = '[D]iff [S]plit' },
      { '<leader>gdl', '<cmd>diffget //2<CR>', desc = '[D]iff [L]eft' },
      { '<leader>gdr', '<cmd>diffget //2<CR>', desc = '[D]iff [R]ight' },
    },
  },
  {
    'radar',
    dir = '~/Developer/Work/m-sommers/nvim-radar',
    dev = true,
    opts = {
      dsid = 2702080918,
    },
  },
}
