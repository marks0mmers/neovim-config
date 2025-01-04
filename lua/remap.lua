vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>e', function()
  require('oil').open()
end, { desc = '[E]xplorer' })
vim.keymap.set('v', 'J', "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', "<cmd>m '<-2<CR>gv=gv")

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<leader>nh', function()
  require('snacks').notifier.show_history()
end, { desc = 'Show Notification History' })
