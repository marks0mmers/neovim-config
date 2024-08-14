-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
          last_active = '<C-\\>',
          next = '<C-Space>',
        },
      }
    end,
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    build = function()
      if not require('lazy.core.config').spec.plugins['mason.nvim'] then
        vim.print 'Installing go dependencies...'
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
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
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
            vim.lsp.log.error 'jdtls: root_dir not found. Please specify a root marker'
          end
        end,
      })
      -- create autocmd to load main class configs on LspAttach.
      -- This ensures that the LSP is fully attached.
      -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      --       vim.api.nvim_create_autocmd('LspAttach', {
      --         pattern = '*.java',
      --         callback = function(args)
      --           local client = vim.lsp.get_client_by_id(args.data.client_id)
      --           -- ensure that only the jdtls client is activated
      --           if client ~= nil and client.name == 'jdtls' then
      --             require('jdtls.dap').setup_dap_main_class_configs()
      --           end
      --         end,
      --       })
    end,
  },
}
