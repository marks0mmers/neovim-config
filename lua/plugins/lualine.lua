return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
    opts = function() require('mini.icons').mock_nvim_web_devicons() end,
  },
  opts = {
    extensions = { 'oil', 'fzf', 'fugitive', 'mason', 'trouble' },
    options = {
      theme = 'tokyonight',
      component_separators = { left = '│', right = '│' },
      section_separators = '',
    },
    sections = {
      lualine_b = {
        {
          'filename',
          path = 0,
          file_status = true,
          symbols = { modified = '  ', readonly = '  ', unnamed = '  ' },
          fmt = function(str)
            if require('utils.marks').get_mark(str) ~= nil then
              return '󰐷 ' .. str
            end
            return str
          end,
        },
      },
      lualine_c = { 'diff', 'diagnostics' },
      lualine_x = { 'encoding', { 'filetype', icon = { align = 'right' } } },
      lualine_y = { 'progress', 'location' },
      lualine_z = {
        function() return vim.uv.os_gethostname():match '(.+)%..*' end,
      },
    },
  },
}
