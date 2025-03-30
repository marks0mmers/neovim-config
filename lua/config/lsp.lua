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
    local map = function(keys, desc, func)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- map('grd', '[G]oto [D]efinition', function() Snacks.picker.lsp_definitions() end)
    -- map('grR', '[G]oto [R]eferences', function() Snacks.picker.lsp_references() end)
    -- map('grD', '[G]oto [D]eclaration', vim.lsp.buf.declaration)
    map('<leader>lD', 'Type [D]efinition', function() Snacks.picker.lsp_type_definitions() end)
    map('<Leader>ld', 'Hover diagnostics', vim.diagnostic.open_float)
    map('<leader>li', '[I]nfo', '<cmd>LspInfo<CR>')

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
