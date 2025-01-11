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
  { 'j-hui/fidget.nvim', opts = {} },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'Bilal2453/luvit-meta', lazy = true },
  { 'williamboman/mason.nvim', opts = {} },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function()
      local lspconfig = require('lspconfig')
      local cmp_lsp = require('cmp_nvim_lsp')
      -- stylua: ignore
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

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
        },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
          end,
          ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            })
          end,
          zls = function()
            lspconfig.zls.setup({
              root_dir = lspconfig.util.root_pattern('.git', 'build.zig', 'zls.json'),
              settings = {
                zls = {
                  enable_inlay_hints = true,
                  enable_snippets = true,
                  warn_style = true,
                },
              },
            })
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 0
          end,
          jdtls = function()
            lspconfig.jdtls.setup({ capabilities = capabilities })
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
          local fzf = require('fzf-lua')
          local map = function(keys, desc, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', '[G]oto [D]efinition', function()
            fzf.lsp_definitions({ jump_to_single_result = true, ignore_current_line = true })
          end)
          map('gr', '[G]oto [R]eferences', function()
            fzf.lsp_references({ jump_to_single_result = true, ignore_current_line = true })
          end)
          map('gi', '[G]oto [I]mplementation', function()
            fzf.lsp_implementations({ jump_to_single_result = true, ignore_current_line = true })
          end)
          map('<leader>lD', 'Type [D]efinition', function()
            fzf.lsp_typedefs({ jump_to_single_result = true, ignore_current_line = true })
          end)
          map('gR', '[N]ative [R]eferences', vim.lsp.buf.references)
          map('<leader>ls', 'Document [S]ymbols', fzf.lsp_document_symbols)
          map('<leader>lr', '[R]ename Symbol', vim.lsp.buf.rename)
          map('<leader>la', 'Code [A]ctions', vim.lsp.buf.code_action)
          map('<leader>lq', 'Diagnostic [Q]uickfix list', vim.diagnostic.setloclist)
          map('<Leader>ld', 'Hover diagnostics', vim.diagnostic.open_float)
          map('<leader>li', '[I]nfo', '<cmd>LspInfo<CR>')
          map('gD', '[G]oto [D]eclaration', vim.lsp.buf.declaration)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', '[T]oggle Inlay [H]ints', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end)
          end
        end,
      })
    end,
  },
}
