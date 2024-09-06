return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('gR', require('telescope.builtin').lsp_references, 'Search [R]eferences')

          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          map('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')

          map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Document Workspace [S]ymbols')

          map('<leader>lr', vim.lsp.buf.rename, '[R]ename Symbol')

          map('<leader>la', vim.lsp.buf.code_action, 'Code [A]ctions')

          map('<leader>lq', vim.diagnostic.setloclist, 'Diagnostic [Q]uickfix list')
          map('<Leader>ld', vim.diagnostic.open_float, 'Hover diagnostics')

          map('<leader>li', '<cmd>LspInfo<CR>', '[I]nfo')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local java_project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local java_workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. java_project_name
      vim.fn.mkdir(java_workspace_dir, 'p')

      local servers = {
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        tsserver = {},
        tailwindcss = {},
        ols = {},
        jdtls = {
          cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-javaagent:' .. vim.fn.expand('$MASON/share/jdtls/lombok.jar'),
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            vim.fn.expand('$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar'),
            '-configuration',
            vim.fn.expand('$MASON/share/jdtls/config'),
            '-data',
            java_workspace_dir,
          },
          root_dir = function()
            return vim.fs.root(0, { '.git', 'mvnw', 'gradlew' })
          end,
          settings = {
            java = {
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = 'interactive' },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              inlayHints = { parameterNames = { enabled = 'all' } },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  'org.hamcrest.MatcherAssert.assertThat',
                  'org.hamcrest.Matchers.*',
                  'org.hamcrest.CoreMatchers.*',
                  'org.junit.jupiter.api.Assertions.*',
                  'java.util.Objects.requireNonNull',
                  'java.util.Objects.requireNonNullElse',
                  'org.mockito.Mockito.*',
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
          handlers = {
            ['$/progress'] = function() end, -- disable progress updates.
          },
          filetypes = { 'java' },
        },

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

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettierd',
        'eslint',
        'iferr',
        'impl',
        'jdtls',
        'java-debug-adapter',
        'java-test',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            -- https://github.com/neovim/nvim-lspconfig/pull/3232
            if server_name == 'tsserver' then
              server_name = 'ts_ls'
            end
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
