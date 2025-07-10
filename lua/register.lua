vim.api.nvim_create_user_command("AddLineNumbers", function()
  require("tools.line_number").prefix_lines_with_line_number()
end, {})

