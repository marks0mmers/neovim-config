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
          function(server_name)
            lspconfig[server_name].setup { capabilities = capabilities }
          end,
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
          jdtls = function()
            lspconfig.jdtls.setup { capabilities = capabilities }
          end,
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
          local fzf = require 'fzf-lua'
          local fzf_opts = { jump_to_single_result = true, ignore_current_line = true }
          local map = function(keys, desc, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', '[G]oto [D]efinition', function()
            fzf.lsp_definitions(fzf_opts)
          end)
          map('gR', '[G]oto [R]eferences', function()
            fzf.lsp_references(fzf_opts)
          end)
          map('gi', '[G]oto [I]mplementation', function()
            fzf.lsp_implementations(fzf_opts)
          end)
          map('gr', '[N]ative [R]eferences', vim.lsp.buf.references)
          map('gD', '[G]oto [D]eclaration', vim.lsp.buf.declaration)
          map('<leader>lD', 'Type [D]efinition', function()
            fzf.lsp_typedefs(fzf_opts)
          end)
          map('<leader>ls', 'Document [S]ymbols', fzf.lsp_document_symbols)
          map('<leader>lr', '[R]ename Symbol', vim.lsp.buf.rename)
          map('<leader>la', 'Code [A]ctions', vim.lsp.buf.code_action)
          map('<Leader>ld', 'Hover diagnostics', vim.diagnostic.open_float)
          map('<leader>li', '[I]nfo', '<cmd>LspInfo<CR>')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { desc = 'Inlay [H]ints' })
          end
        end,
      })
    end,
  },
}
