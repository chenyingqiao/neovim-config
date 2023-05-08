require("auto-save").setup{
  enabled = true,
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")
    -- 获取文件名
    local filename = fn.bufname(buf)
    -- 获取文件后缀
	local file_extension = ""
	if string.find(filename, "%.") then
		file_extension = string.sub(filename, string.find(filename, "%.[^%.]+$") + 1)
	else
		-- 如果没有找到文件后缀，可以为文件设置默认后缀
		file_extension = ".txt"
	end
    if fn.getbufvar(buf, "&modifiable") == 1 and
      -- 判断是否需要自动保存
      file_extension == ".txt" or file_extension == ".text" then
      return true -- met condition(s), can save
    end
    return false -- can't save
  end,
}

-- require("auto-save").setup{
-- 	enabled = true,
-- 	condition = function(buf)
-- 		local fn = vim.fn
-- 		local utils = require("auto-save.utils.data")
-- 		if
-- 			fn.getbufvar(buf, "&modifiable") == 1 and
-- 			utils.not_in(fn.getbufvar(buf, "&filetype"), {"text"}) then
-- 			return true -- met condition(s), can save
-- 		end
-- 		return false -- can't save
-- 	end,
-- }
