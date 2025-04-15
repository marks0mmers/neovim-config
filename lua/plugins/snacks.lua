return {
  'folke/snacks.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  priority = 1000,
  lazy = false,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    debug = {},
    indent = {},
    input = {},
    notifier = {
      filter = function(noti) return noti.msg ~= 'No information available' end,
    },
    picker = {
      matcher = {
        frequency = true,
      },
    },
    rename = {},
    statuscolumn = {},
  },
  keys = {
    { '<leader>ff', function() Snacks.picker.smart() end, desc = '[F]iles' },
    { '<leader>fr', function() Snacks.picker.resume() end, desc = '[R]esume' },
    { '<leader>fh', function() Snacks.picker.help() end, desc = '[H]elp' },
    { '<leader>fk', function() Snacks.picker.keymaps() end, desc = '[K]eymaps' },
    { '<leader>fb', function() Snacks.picker() end, desc = '[B]uiltin' },
    { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = '[D]iagnostics' },
    { '<leader>fw', function() Snacks.picker.grep() end, desc = '[W]ord' },
    { '<leader>f.', function() Snacks.picker.recent() end, desc = 'Recent Files ("." for repeat)' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Buffers' },
    {
      '<leader>fn',
      function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
      desc = '[N]eovim files',
    },
  },
}
