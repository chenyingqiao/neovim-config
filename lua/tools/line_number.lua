local M = {}

function M.prefix_lines_with_line_number()
  local bufnr = vim.api.nvim_get_current_buf()
  local total_lines = vim.api.nvim_buf_line_count(bufnr)
  local new_lines = {}

  for i = 1, total_lines do
    local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
    new_lines[#new_lines + 1] = string.format("%d %s", i, line)
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, total_lines, false, new_lines)
end

return M

