-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>l', group = '[L]SP' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>g', group = '[G]it' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    }
  end,
}
