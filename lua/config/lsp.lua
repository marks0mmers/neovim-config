local lspconfig = require 'lspconfig'

vim.lsp.config.lua_ls = {
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

vim.lsp.enable { 'cssls', 'gopls', 'html', 'jsonls', 'lua_ls', 'pyright', 'rust_analyzer', 'ts_ls', 'marksman' }

lspconfig.eslint.setup {
  capabailities = require('blink.cmp').get_lsp_capabilities(),
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end,
}

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
lspconfig.zls.setup {
  capabailities = require('blink.cmp').get_lsp_capabilities(),
  settings = {
    zls = {
      enable_inlay_hints = true,
      enable_snippets = true,
      warn_style = true,
    },
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', '<leader>td', vim.diagnostic.open_float, { desc = 'Toggle [D]iagnostics' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition()' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      local toggle = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end
      vim.keymap.set('n', '<leader>th', toggle, { desc = 'Inlay [H]ints' })
    end
  end,
})
