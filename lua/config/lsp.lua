local cmp = require 'blink.cmp'
local capabilities = cmp.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config('*', {
  capabilities = capabilities,
})

local configs = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file('lsp/*', true)) do
  local name = vim.fn.fnamemodify(v, ':t:r')
  configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(configs))

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', '<leader>td', vim.diagnostic.open_float, { desc = 'Toggle [D]iagnostics' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set(
        'n',
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
        { desc = 'Inlay [H]ints' }
      )
    end
  end,
})
