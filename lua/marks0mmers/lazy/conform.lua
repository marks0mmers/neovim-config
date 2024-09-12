return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = function()
    local js_formatters = { 'prettierd', 'prettier', stop_after_first = true }
    return {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {}
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        html = { 'prettierd' },
        javascript = js_formatters,
        javascriptreact = js_formatters,
        typescript = js_formatters,
        typescriptreact = js_formatters,
        scss = js_formatters,
        go = { 'gofumpt', 'goimports', 'golines' },
        rust = { 'rustfmt' },
      },
    }
  end,
}
