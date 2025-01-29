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
  local marks = vim.iter(globalMarks):fold({}, function(acc, m)
    local mark = vim.api.nvim_get_mark(m, {})
    if mark[1] ~= 0 then acc[m] = mark end
    return acc
  end)
  table.sort(marks, function(a, b) return a[1] < b[1] end)
  return marks
end

---@param filename string
---@return string|nil
M.get_mark = function(filename)
  return vim.iter(M:get_mark_table()):find(function(_, fileinfo) return vim.fn.fnamemodify(fileinfo[4], ':t') == filename end)
end

M.add_file_to_marks = function()
  local marks = M.get_mark_table()
  local mark_exists = vim.iter(marks):any(function(_, fileinfo) return vim.api.nvim_buf_get_name(0) == vim.fn.expand(fileinfo[4]) end)
  if not mark_exists then
    local empty = vim.iter(globalMarks):find(function(m) return marks[m] == nil end)
    vim.cmd('normal! m' .. empty)
  end
end

M.next_mark = function()
  local marks = M.get_mark_table()
  local curr = M.get_mark(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t'))
  if curr == nil then
    vim.cmd("normal! 'A")
    return
  end
  local idx = vim.iter(ipairs(globalMarks)):find(function(_, v) return v == curr end)
  local mark = marks[globalMarks[idx + 1]] ~= nil and globalMarks[idx + 1] or 'A'
  vim.cmd("normal! '" .. mark)
end

M.prev_mark = function()
  local marks = M.get_mark_table()
  local curr = M.get_mark(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t'))
  if curr == nil then
    vim.cmd("normal! 'A")
    return
  end
  local idx = vim.iter(ipairs(globalMarks)):find(function(_, v) return v == curr end)
  local last_mark = vim.iter(marks):map(function(k, _) return k end):fold(globalMarks[1], function(a, b) return a > b and a or b end)
  local mark = marks[globalMarks[idx - 1]] ~= nil and globalMarks[idx - 1] or last_mark
  vim.cmd("normal! '" .. mark)
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
