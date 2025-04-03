local jdtls_path = '/opt/homebrew/opt/jdtls/libexec'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local cache_dir = vim.fn.stdpath 'data'
local workspace_dir = cache_dir .. '/jdtls/' .. project_name

local lombok = jdtls_path .. '/plugins/lombok.jar'
local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

require('jdtls').start_or_attach {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. lombok,
    '--data',
    workspace_dir,
  },
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),
  capabilities = capabilities,
  settings = {
    java = {},
  },
  init_options = {
    bundles = {},
  },
}
