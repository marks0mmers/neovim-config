return {
  cmd = { 'zls' },
  root_markers = { '.git', 'build.zig', 'zls.json' },
  on_new_config = function(new_config, new_root_dir)
    if vim.fn.filereadable(vim.fs.joinpath(new_root_dir, 'zls.json')) ~= 0 then
      new_config.cmd = { 'zls', '--config-path', 'zls.json' }
    end
  end,
  filetypes = { 'zig', 'zir' },
  single_file_support = true,
}
