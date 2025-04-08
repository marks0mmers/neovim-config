return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'mfussenegger/nvim-jdtls' },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
  config = function()
    local lspconfig = require 'lspconfig'

    local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

    local servers = { 'cssls', 'gopls', 'html', 'jsonls', 'pyright', 'rust_analyzer', 'ts_ls', 'marksman' }

    for _, server in ipairs(servers) do
      lspconfig[server].setup { capabilities = capabilities }
    end

    lspconfig.eslint.setup {
      capabailities = capabilities,
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    }

    lspconfig.lua_ls.setup {
      capabailities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          workspace = {
            checkThirdParty = false,
            telemetry = { enable = false },
            library = {
              '${3rd}/love2d/library',
            },
          },
        },
      },
    }

    lspconfig.zls.setup {
      capabailities = capabilities,
      root_dir = lspconfig.util.root_pattern('.git', 'build.zig', 'zls.json'),
      settings = {
        zls = {
          enable_inlay_hints = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    }
  end,
}
