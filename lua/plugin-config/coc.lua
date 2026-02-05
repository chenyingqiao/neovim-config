-- 某些服务器对备份文件有问题，参见 #649
vim.opt.backup = false
vim.opt.writebackup = false

-- 较长的 updatetime（默认为 4000 ms = 4s）会导致明显的
-- 延迟和糟糕的用户体验
vim.opt.updatetime = 300

-- 始终显示 signcolumn，否则每次
-- 诊断信息出现/解决时都会移动文本
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- 自动补全
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- 使用 Tab 触发补全并导航
-- 注意：默认总是有一个补全项被选中，你可能想要通过在配置文件中设置
-- `"suggest.noselect": true` 来启用无选择模式
-- 注意：在将此配置��加到你的配置之前，使用命令 ':verbose imap <tab>' 确保 Tab
-- 没有被其他插件映射
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- 使用 <CR> 接受选中的补全项或通知 coc.nvim 格式化
-- <C-g>u 会打断当前的撤销操作，请自行选择
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- 使用 <c-j> 触发代码片段
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- 使用 <c-space> 触发补全
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- 使用 `[g` 和 `]g` 导航诊断信息
-- 使用 `:CocDiagnostics` 在位置列表中获取当前缓冲区的所有诊断信息
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo 代码导航
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- 使用 K 在预览窗口中显示文档
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- 在 CursorHold 事件（光标闲置时）高亮符号及其引用
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- 符号重命名
keyset("n", "<C-v>rn", "<Plug>(coc-rename)", {silent = true})


-- 格式化选中的代码
keyset("v", "<C-v>f", "<Plug>(coc-format-selected)", {silent = true})


-- 为指定文件类型设置 formatexpr
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json,go,py",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- 在跳转占位符时更新签名帮助
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- 将 codeAction 应用到选中区域
-- 示例：对当前段落使用 `<leader>aap`
local opts = {silent = true, nowait = true}
-- keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
-- keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- 为光标位置应用代码操作重新映射键
-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- 为影响整个缓冲区的代码操作重新映射键
-- keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- 为将代码操作应用到当前缓冲区重新映射键
-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)

-- 为应用重构代码操作重新映射键
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
--keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- 在当前行运行 Code Lens 操作
-- keyset("n", "<C-S-cl>", "<Plug>(coc-codelens-action)", opts)


-- 映射函数和类文本对象
-- 注意：需要语言服务器支持 'textDocument.documentSymbol'
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- 重新映射 <C-f> 和 <C-b> 来滚动浮动窗口/弹出窗口
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<S-Up>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"', opts)
keyset("n", "<S-Down>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"', opts)
keyset("i", "<S-Up>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<S-Down>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<S-Up>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"', opts)
keyset("v", "<S-Down>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"', opts)


-- 使用 CTRL-S 进行选择范围
-- 需要语言服务器支持 'textDocument/selectionRange'
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- 添加 `:Format` 命令来格式化当前缓冲区
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     group = "CocGroup",
--     pattern = {"*.go","*.py"},
--     command = "call CocActionAsync('format')",
--     desc = "auto format"
-- })

-- 添加 `:Fold` 命令来折叠当前缓冲区
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- 添加 `:OR` 命令来整理当前缓冲区的导入
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     group = "CocGroup",
--     pattern = {"*.go","*.py"},
--     command = "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
--     desc = "auto import"
-- })

-- 添加 (Neo)Vim 的原生状态栏支持
-- 注意：有关与提供自定义状态栏的外部插件集成的信息，请参见 `:h coc-status`
-- 例如：lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- CoCList 的映射
-- 代码操作和 coc 相关功能
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- 显示所有诊断信息
keyset("n", "<C-v>a", ":<C-u>CocList diagnostics<cr>", opts)
-- 管理扩展
keyset("n", "<C-v>e", ":<C-u>CocList extensions<cr>", opts)
-- 显示命令
keyset("n", "<C-v>c", ":<C-u>CocList commands<cr>", opts)
-- 查找当前文档的符号
keyset("n", "<C-v>o", ":<C-u>CocOutline<cr>", opts)
-- 搜索工作区符号
keyset("n", "<C-v>s", ":<C-u>CocList -I symbols<cr>", opts)
-- 对下一项执行默认操作
-- keyset("n", "<C-v>j", ":<C-u>CocNext<cr>", opts)
-- 对上一项执行默认操作
-- keyset("n", "<C-v>k", ":<C-u>CocPrev<cr>", opts)
-- 恢复最新的 coc 列表
-- keyset("n", "<C-v>p", ":<C-u>CocListResume<cr>", opts)
-- coc-snippet 代码片段快捷键设置
-- " 使用 <C-l> 触发代码片段展开。
-- imap <C-l> <Plug>(coc-snippets-expand)
--
-- " 使用 <C-j> 为代码片段的视觉占位符选择文本。
-- vmap <C-j> <Plug>(coc-snippets-select)
