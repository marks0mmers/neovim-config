return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local fzf = require('fzf-lua')

      fzf.register_ui_select()
      vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>fs', fzf.builtin, { desc = '[F]ind [S]elect Builtin' })
      vim.keymap.set('n', '<leader>fd', fzf.diagnostics_workspace, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fw', fzf.live_grep, { desc = '[F]ind Word' })
      vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = '[F]ind [G]it' })
      vim.keymap.set('n', '<leader>f.', fzf.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>f/', fzf.lines, { desc = '[F]ind [/] in Open Files' })
      vim.keymap.set('n', '<leader>fn', function() fzf.files({ cwd = vim.fn.stdpath('config') }) end, { desc = '[F]ind [N]eovim files' })

      return {
        grep = {
          actions = {
            ['ctrl-q'] = {
              fn = fzf.actions.file_edit_or_qf,
              prefix = 'select-all+',
            },
          },
        },
      }
    end,
  },
}
