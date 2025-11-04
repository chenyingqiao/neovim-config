vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        -- 使用 nvim 内置lsp
        diagnostics = "coc",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }},
        -- 自定义过滤规则，不显示特定 buffer
        custom_filter = function(buf_number, buf_numbers)
            -- 过滤掉 claudecode 相关的 buffer
            local buf_name = vim.fn.bufname(buf_number)
            return not (buf_name:match("claude") or buf_name:match("Claude"))
        end
    }
}
