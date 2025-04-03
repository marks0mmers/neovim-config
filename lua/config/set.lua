vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
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
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 999
vim.opt.winborder = 'rounded'

vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.exrc = true
vim.opt.secure = true
local workspace_path = vim.fn.getcwd()
local cache_dir = vim.fn.stdpath 'data'
local unique_id = vim.fn.fnamemodify(workspace_path, ':t') .. '_' .. vim.fn.sha256(workspace_path):sub(1, 8)
local shadafile = cache_dir .. '/shadas/' .. unique_id .. '.shada'
vim.opt.shadafile = shadafile

local signs = {
  ERROR = '',
  WARN = '',
  HINT = '󰌵',
  INFO = '',
}

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.ERROR,
      [vim.diagnostic.severity.WARN] = signs.WARN,
      [vim.diagnostic.severity.HINT] = signs.HINT,
      [vim.diagnostic.severity.INFO] = signs.INFO,
    },
  },
  virtual_text = {
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
    prefix = function(diagnostic) return signs[vim.diagnostic.severity[diagnostic.severity]] end,
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
}

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
