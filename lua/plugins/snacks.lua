return {
  'folke/snacks.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    indent = {},
    input = {},
    picker = {
      matcher = {
        frequency = true,
      },
    },
    debug = {},
    notifier = {
      filter = function(noti) return noti.msg ~= 'No information available' end,
    },
    statuscolumn = {},
  },
  keys = {
    { '<leader>ff', function() Snacks.picker.smart() end, desc = '[F]ind [F]iles' },
    { '<leader>fr', function() Snacks.picker.resume() end, desc = '[F]ind [R]esume' },
    { '<leader>fh', function() Snacks.picker.help() end, desc = '[F]ind [H]elp' },
    { '<leader>fk', function() Snacks.picker.keymaps() end, desc = '[F]ind [K]eymaps' },
    { '<leader>fs', function() Snacks.picker() end, desc = '[F]ind [S]elect Builtin' },
    { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = '[F]ind [D]iagnostics' },
    { '<leader>fw', function() Snacks.picker.grep() end, desc = '[F]ind Word' },
    { '<leader>f.', function() Snacks.picker.recent() end, desc = '[F]ind Recent Files ("." for repeat)' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
    {
      '<leader>fn',
      ---@diagnostic disable-next-line: assign-type-mismatch
      function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[F]ind [N]eovim files',
    },
  },
}
