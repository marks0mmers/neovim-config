require('marks0mmers.remap')
require('marks0mmers.lazy_init')
require('marks0mmers.set')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
