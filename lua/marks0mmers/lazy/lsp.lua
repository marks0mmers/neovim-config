return {
  { 'nvim-java/nvim-java' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local fzf = require('fzf-lua')

          map('gd', function()
            fzf.lsp_definitions({ jump_to_single_result = true, ignore_current_line = true })
          end, '[G]oto [D]efinition')

          map('gr', function()
            fzf.lsp_references({ jump_to_single_result = true, ignore_current_line = true })
          end, '[G]oto [R]eferences')
          map('gR', vim.lsp.buf.references, '[N]ative [R]eferences')

          map('gI', function()
            fzf.lsp_implementations({ jump_to_single_result = true, ignore_current_line = true })
          end, '[G]oto [I]mplementation')

          map('<leader>lD', function()
            fzf.lsp_typedefs({ jump_to_single_result = true, ignore_current_line = true })
          end, 'Type [D]efinition')

          map('<leader>ls', fzf.lsp_document_symbols, 'Document [S]ymbols')

          map('<leader>lr', vim.lsp.buf.rename, '[R]ename Symbol')

          map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ctions')

          map('<leader>lq', vim.diagnostic.setloclist, 'Diagnostic [Q]uickfix list')
          map('<Leader>ld', vim.diagnostic.open_float, 'Hover diagnostics')

          map('<leader>li', '<cmd>LspInfo<CR>', '[I]nfo')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
    end,

    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        ts_ls = {},
        tailwindcss = {},
        ols = {},
        jsonls = {},
        ['kotlin_language_server'] = {},
        lemminx = {},
        ocamllsp = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup()
      require('java').setup()
      require('lspconfig').jdtls.setup({})
      require('lspconfig').gleam.setup({})
      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
