return {
  'tpope/vim-sleuth',
  'brenoprata10/nvim-highlight-colors',
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = true,
        keybindings = {
          left = '<C-w><C-h>',
          down = '<C-w><C-j>',
          up = '<C-w><C-k>',
          right = '<C-w><C-l>',
          last_active = '<C-w><C-\\>',
          next = '<C-w><C-Space>',
        },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup({})
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    build = function()
      if not require('lazy.core.config').spec.plugins['mason.nvim'] then
        vim.print('Installing go dependencies...')
        vim.cmd.GoInstallDeps()
      end
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'williamboman/mason.nvim', optional = true }, -- by default use Mason for go dependencies
    },
    opts = {},
  },
  {
    'marko-cerovac/material.nvim',
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup({ n_lines = 500 })

      require('mini.surround').setup()

      require('mini.comment').setup()

      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function(_, opts)
      -- setup autocmd on filetype detect java
      vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'java', -- autocmd to start jdtls
        callback = function()
          if opts.root_dir and opts.root_dir ~= '' then
            require('jdtls').start_or_attach(opts)
          else
            vim.lsp.log.error('jdtls: root_dir not found. Please specify a root marker')
          end
        end,
      })
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add({
        { '<leader>l', group = '[L]SP' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it' },
        { '<leader>gh', group = 'Git [H]unk', mode = { 'n', 'v' } },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
