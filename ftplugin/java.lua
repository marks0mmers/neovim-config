local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local cache_dir = vim.fn.stdpath 'data'
local workspace_dir = cache_dir .. '/jdtls/' .. project_name

local lombok = '/opt/homebrew/opt/jdtls/libexec/plugins/lombok.jar'
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
    java = {
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        hashCodeEquals = { useJava7Objects = true },
        useBlocks = true,
      },
      contentProvider = { preferred = 'fernflower' },
      maven = { downloadSources = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
}
