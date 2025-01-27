vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.netrw_liststyle = 3

local signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}

vim.fn.sign_define('DiagnosticSignError', { text = signs.ERROR, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = signs.WARN, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignHint', { text = signs.HINT, texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = signs.INFO, texthl = 'DiagnosticSignInfo' })

vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic) return signs[vim.diagnostic.severity[diagnostic.severity]] end,
  },
})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
