local M = {}

local globalMarks = {
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
}

---@return {[string]: vim.api.keyset.get_mark}
M.get_mark_table = function()
  local marks = {}
  for _, v in ipairs(globalMarks) do
    local mark = vim.api.nvim_get_mark(v, {}) ---@type vim.api.keyset.get_mark
    if mark[1] ~= 0 then marks[v] = mark end
  end
  table.sort(marks, function(a, b) return a[1] < b[1] end)
  return marks
end

M.select_mark = function()
  local marks = M.get_mark_table()
  local option_labels = {}
  for key, _ in pairs(marks) do
    table.insert(option_labels, key)
  end
  table.sort(option_labels)
  vim.ui.select(option_labels, {
    winopts = {
      height = 0.5,
    },
    prompt = 'Select Mark: ',
    format_item = function(item)
      local filename_only = vim.fn.fnamemodify(marks[item][4], ':t')
      local formatted_label = item .. ' - ' .. filename_only
      return formatted_label
    end,
  }, function(mark)
    if mark then vim.cmd("normal! '" .. mark) end
  end)
end

---@param filename string
---@return string|nil
M.get_mark = function(filename)
  local marks = M.get_mark_table()
  for mark, fileinfo in pairs(marks) do
    if vim.fn.fnamemodify(fileinfo[4], ':t') == filename then return mark end
  end
  return nil
end

M.add_file_to_marks = function()
  local marks = M.get_mark_table()
  for _, fileinfo in pairs(marks) do
    local filename = fileinfo[4]
    local current_filename = vim.api.nvim_buf_get_name(0)
    if current_filename == vim.fn.expand(filename) then return end
  end
  for _, v in ipairs(globalMarks) do
    if marks[v] == nil then
      vim.cmd('normal! m' .. v)
      return
    end
  end
end

M.next_mark = function()
  local marks = M.get_mark_table()
  local current_mark = M.get_mark(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t'))
  if current_mark == nil then
    vim.cmd("normal! 'A")
  else
    local index = nil
    for i, v in ipairs(globalMarks) do
      if v == current_mark then index = i end
    end
    if marks[globalMarks[index + 1]] == nil then
      vim.cmd("normal! 'A")
    else
      vim.cmd("normal! '" .. globalMarks[index + 1])
    end
  end
end

M.prev_mark = function()
  local marks = M.get_mark_table()
  local current_mark = M.get_mark(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t'))
  if current_mark == nil then
    vim.cmd("normal! 'A")
  else
    local index = nil
    for i, v in ipairs(globalMarks) do
      if v == current_mark then index = i end
    end
    local keys = {}
    for k, _ in pairs(marks) do
      table.insert(keys, k)
    end
    table.sort(keys, function(a, b) return a > b end)
    local last_mark = keys[1]
    if marks[globalMarks[index - 1]] == nil then
      print(last_mark)
      vim.cmd("normal! '" .. last_mark)
    else
      vim.cmd("normal! '" .. globalMarks[index - 1])
    end
  end
end

M.clear_global_marks = function()
  for _, v in ipairs(globalMarks) do
    vim.api.nvim_del_mark(v)
  end
end

M.lualine_global = function()
  local marks = M.get_mark_table()
  local lualine_marks = '󰐷 '
  for mark, fileinfo in pairs(marks) do
    local filename = fileinfo[4]
    local current_filename = vim.api.nvim_buf_get_name(0)
    local filename_only = vim.fn.fnamemodify(filename, ':t')
    local mark_string = string.format('%s: %s', mark, filename_only)
    if current_filename ~= vim.fn.expand(filename) then lualine_marks = lualine_marks .. mark_string .. ' ' end
  end

  return lualine_marks
end

return M
