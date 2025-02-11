return {
  {
    'nvim-java/nvim-java',
    opts = {
      root_markers = {
        'mvnw',
        'gradlew',
        '.git',
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    --- @module 'lazydev'
    --- @type lazydev.Config
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'j-hui/fidget.nvim', opts = {} },
  { 'williamboman/mason.nvim', opts = {} },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function()
      local lspconfig = require 'lspconfig'
      local cmp = require 'blink.cmp'
      local capabilities = cmp.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

      lspconfig.zls.setup {
        root_dir = lspconfig.util.root_pattern('.git', 'build.zig', 'zls.json'),
        settings = {
          zls = {
            enable_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
          },
        },
      }
      vim.g.zig_fmt_parse_errors = 0
      vim.g.zig_fmt_autosave = 0

      --- @module 'mason-lspconfig'
      --- @type MasonLspconfigSettings
      return {
        automatic_installation = true,
        ensure_installed = {
          'gopls',
          'pyright',
          'rust_analyzer',
          'ts_ls',
          'tailwindcss',
          'ols',
          'jsonls',
          'kotlin_language_server',
          'lemminx',
          'ocamllsp',
          'lua_ls',
          'cssls',
        },
        handlers = {
          function(server_name) lspconfig[server_name].setup { capabilities = capabilities } end,
          lua_ls = function()
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            }
          end,
          eslint = function()
            lspconfig.eslint.setup {
              capabilities = capabilities,
              on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                  buffer = bufnr,
                  command = 'EslintFixAll',
                })
              end,
            }
          end,
          jdtls = function() lspconfig.jdtls.setup { capabilities = capabilities } end,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, desc, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', '[G]oto [D]efinition', function() Snacks.picker.lsp_definitions() end)
          map('gR', '[G]oto [R]eferences', function() Snacks.picker.lsp_references() end)
          map('gi', '[G]oto [I]mplementation', function() Snacks.picker.lsp_implementations() end)
          map('gr', '[N]ative [R]eferences', vim.lsp.buf.references)
          map('gD', '[G]oto [D]eclaration', vim.lsp.buf.declaration)
          map('<leader>lD', 'Type [D]efinition', function() Snacks.picker.lsp_type_definitions() end)
          map('<leader>ls', 'Document [S]ymbols', function() Snacks.picker.lsp_symbols() end)
          map('<leader>lr', '[R]ename Symbol', vim.lsp.buf.rename)
          map('<leader>la', 'Code [A]ctions', vim.lsp.buf.code_action)
          map('<Leader>ld', 'Hover diagnostics', vim.diagnostic.open_float)
          map('<leader>li', '[I]nfo', '<cmd>LspInfo<CR>')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set(
              'n',
              '<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
              { desc = 'Inlay [H]ints' }
            )
          end
        end,
      })
    end,
  },
}
