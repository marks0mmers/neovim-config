return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'rcarriga/nvim-dap-ui', opts = {} },
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  opts = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = '[B]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Run to [C]ursor' })
    ---@diagnostic disable-next-line: missing-fields
    vim.keymap.set('n', '<leader>d?', function() ui.eval(nil, { enter = true }) end, { desc = '[?] is under cursor' })

    vim.keymap.set('n', '<F1>', dap.continue)
    vim.keymap.set('n', '<F2>', dap.step_into)
    vim.keymap.set('n', '<F3>', dap.step_over)
    vim.keymap.set('n', '<F4>', dap.step_out)
    vim.keymap.set('n', '<F5>', dap.step_back)
    vim.keymap.set('n', '<F13>', dap.restart)

    dap.listeners.before.attach.dapui_config = function() ui.open() end
    dap.listeners.before.launch.dapui_config = function() ui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
    dap.listeners.before.event_exited.dapui_config = function() ui.close() end

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '8123',
      executable = {
        command = 'js-debug-adapter',
      },
    }

    dap.adapters['pwa-chrome'] = {
      type = 'server',
      host = 'localhost',
      port = '8123',
      executable = {
        command = 'js-debug-adapter',
      },
    }

    for _, lang in ipairs { 'typescript', 'javascript' } do
      dap.configurations[lang] = {
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to Node',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          -- use nvim-dap-vscode-js's pwa-chrome debug adapter
          type = 'pwa-chrome',
          request = 'launch',
          -- name of the debug action
          name = 'Launch Chrome',
          -- default react dev server url
          url = 'http://localhost:3000',
          -- for TypeScript/Svelte
          sourceMaps = true,
          webRoot = '${workspaceFolder}/src',
          protocol = 'inspector',
          port = 9222,
          -- skip files from vite's hmr
          skipFiles = { '**/node_modules/**/*' },
        },
      }
    end
  end,
  config = function() end,
}
