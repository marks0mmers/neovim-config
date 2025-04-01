return {
  { 'j-hui/fidget.nvim', opts = {} },
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
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local cmp = require 'blink.cmp'

      local opts = { capabailities = cmp.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()) }

      lspconfig.cssls.setup(opts)
      lspconfig.gopls.setup(opts)
      lspconfig.html.setup(opts)
      lspconfig.jsonls.setup(opts)
      lspconfig.pyright.setup(opts)
      lspconfig.rust_analyzer.setup(opts)
      lspconfig.ts_ls.setup(opts)

      lspconfig.eslint.setup {
        capabailities = opts.capabilities,
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
        end,
      }

      lspconfig.lua_ls.setup {
        capabailities = opts.capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      }

      lspconfig.zls.setup {
        capabailities = opts.capabilities,
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
  },
}
