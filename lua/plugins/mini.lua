return {
  'echasnovski/mini.nvim',
  init = function()
    require('mini.ai').setup { n_lines = 500 }

    local miniclue = require 'mini.clue'
    miniclue.setup {
      window = {
        delay = 500,
        config = {
          width = 'auto',
        },
      },
      triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'x', keys = "'" },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },
      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = 'n', keys = '<leader>f', desc = '[F]ind' },
        { mode = 'n', keys = '<leader>g', desc = '[G]it' },
        { mode = 'n', keys = '<leader>m', desc = '[M]arks' },
        { mode = 'n', keys = '<leader>s', desc = '[S]plit' },
        { mode = 'n', keys = '<leader>t', desc = '[T]oggle/[T]est' },
        { mode = 'n', keys = '<leader>gd', desc = '[D]iff' },
      },
    }
    miniclue.set_mapping_desc('n', 'gx', 'Execute app for file under cursor')

    require('mini.comment').setup {}

    require('mini.files').setup {}
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
    })

    require('mini.surround').setup {}
  end,
}
