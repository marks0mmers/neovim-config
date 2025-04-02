vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('v', 'J', function() vim.cmd.m "'>+1<CR>gv=gv" end)
vim.keymap.set('v', 'K', function() vim.cmd.m "'<-2<CR>gv=gv" end)

vim.keymap.set('n', '<C-f>', function() vim.cmd.silent { args = { '!tmux', 'neww', 'tmux-sessionizer' } } end)
vim.keymap.set(
  'n',
  '<leader>tn',
  function() require('snacks').notifier.show_history() end,
  { desc = '[N]otification History' }
)
-- vim.keymap.set('n', '<C-e>', require('utils.marks').select_mark, { desc = 'Show Marks' })
vim.keymap.set('n', '<C-j>', require('utils.marks').next_mark, { desc = 'Next mark' })
vim.keymap.set('n', '<C-k>', require('utils.marks').prev_mark, { desc = 'Prev mark' })
vim.keymap.set('n', '<leader>md', require('utils.marks').clear_global_marks, { desc = '[D]elete all global marks' })
vim.keymap.set('n', '<leader>a', require('utils.marks').add_file_to_marks, { desc = '[A]dd file to marks' })
