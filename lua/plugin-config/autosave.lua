require("auto-save").setup {
	enabled = true,
	condition = function(buf)
		-- 1. 缓冲区无效直接退出
		if not vim.api.nvim_buf_is_valid(buf) then return false end

		local fn = vim.fn
		local filename = fn.bufname(buf)

		-- 2. 取扩展名
		local ext = filename:match("(%.%w+)$") or ".txt"

		-- 3. 正确的逻辑：可写 且 不是 txt/text
		return fn.getbufvar(buf, "&modifiable") == 1
			and ext ~= ".txt"
			and ext ~= ".text"
	end,
	-- 4. 触发事件保守一点，减少定时器
	trigger_events = { "InsertLeave", "TextChanged" },
	debounce_delay = 1000,
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
