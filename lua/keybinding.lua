-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = {
  noremap = true,
  silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opt)
map("v", "g_", "$", opt)
map("n", "$", "g_", opt)
map("n", "g_", "$", opt)

map("n", "<leader>s", ":w<CR>", opt)
map("n", "<leader>wq", ":wqa!<CR>", opt)

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map("n", "<C-j>", "15j", opt)
map("n", "<C-k>", "15k", opt)
map("v", "<C-j>", "15j", opt)
map("v", "<C-k>", "15k", opt)

-- magic search
map("n", "/", "/\\v", { noremap = true, silent = false })
map("v", "/", "/\\v", { noremap = true, silent = false })

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "<M-Down>", ":move '>+1<CR>gv-gv", opt)
map("v", "<M-Up>", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

-- 退出
-- map("n", "qq", ":q!<CR>", opt)
map("n", "<leader>qq", ":qa!<CR>", opt)

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<Left>", opt)
map("i", "<C-l>", "<Right>", opt)
map("i", "<C-j>", "<Down>", opt)
map("i", "<C-k>", "<Up>", opt)
map("i", "<C-e>", "<S-Right>", opt)
map("i", "<C-b>", "<S-Left>", opt)

------------------------------------------------------------------
-- windows 分屏快捷键
------------------------------------------------------------------
-- 取消 s 默认功能
map("n", "s", "", opt)
map("n", "sv", ":vsp<CR>", opt)
map("n", "ss", ":sp<CR>", opt)
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt) -- close others
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)
-- 相等比例
map("n", "sg", "<C-w>=", opt)
map("n", "sf", "<C-w>_<C-w>|", opt)
-- 调整上下比利
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
-- 调整左右比利
map("n", "sh", ":vertical resize -10<CR>", opt)
map("n", "sl", ":vertical resize +10<CR>", opt)
-- Terminal相关
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<M-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<M-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<M-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<M-l>", [[ <C-\><C-N><C-w>l ]], opt)
--------------------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}

-- treesitter 折叠
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)

-- nvim-tree
-- map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>fk", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>fj", ":NvimTreeFocus<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = { -- 打开文件或文件夹
  { key = { "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<CR>", action = "system_open" },
  -- v分屏打开文件
  { key = "v", action = "vsplit" },
  -- h分屏打开文件
  { key = "h", action = "split" },
  -- Ignore (node_modules)
  { key = "i", action = "toggle_ignored" },
  -- Hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "K", action = "show_info_popup" },
  -- 文件操作
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "I", action = "toggle_file_info" },
  { key = "n", action = "tabnew" },
  { key = "S", action = "search_node" },
  { key = "E", action = "expand_all" },
  { key = "F", action = "clear_live_filter" },
  { key = "f", action = "live_filter" },
  { key = "W", action = "collapse_all" },
  -- 进入下一级
  { key = { "]" }, action = "cd" },
  -- 进入上一级
  { key = { "[" }, action = "dir_up" },
}
-- bufferline
-- 左右Tab切换
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opt)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>xn", ":Bdelete!<CR>", opt)
-- map("n", "<C-w>", ":Bdelete!<CR>", opt)
-- 关闭左/右侧标签页
map("n", "<leader>xl", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>xr", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他标签页
map("n", "<leader>xo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中标签页
map("n", "<leader>xx", ":BufferLinePickClose<CR>", opt)

-- Telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opt)
map("n", "<leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<leader>fr", ":Telescope grep_string<CR>", opt)
map("n", "<leader>fib", ":Telescope git_branches<CR>", opt)
map("n", "<leader>fis", ":Telescope git_status<CR>", opt)
map("n", "<leader>fit", ":Telescope git_stash<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
    -- 历史记录
    -- ["<Down>"] = "cycle_history_next",
    -- ["<Up>"] = "cycle_history_prev",
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = "gcc", -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}
-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gcc", { noremap = false })
-- vimspector
pluginKeys.mapVimspector = function()
  -- 开始
  map("n", "<leader>dd", ":call vimspector#Launch()<CR>", opt)
  -- 结束
  map("n", "<Leader>de", ":call vimspector#Reset()<CR>", opt)
  -- 继续
  map("n", "<Leader>dc", ":call vimspector#Continue()<CR>", opt)
  -- 设置断点
  map("n", "<Leader>dt", ":call vimspector#ToggleBreakpoint()<CR>", opt)
  map("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>", opt)
  --  stepOver, stepOut, stepInto
  map("n", "<leader>dj", "<Plug>VimspectorStepOver", opt)
  map("n", "<F5>", "<Plug>VimspectorStepOver", opt)
  map("n", "<leader>do", "<Plug>VimspectorStepOut", opt)
  map("n", "<leader>di", "<Plug>VimspectorStepInto", opt)
  map("n", "<leader>dg", ":call vimspector#RunToCursor()<CR>", opt)
  -- 查看断点列表
  map("n", "<leader>db", "<Plug>VimspectorBreakpoints", opt)
  map("n", "<leader>dr", ":call vimspector#SetCurrentThread()<CR>", opt)
  map("n", "<leader>dp", ":call vimspector#PauseContinueThread()<CR>", opt)
  map("n", "<leader>dv", "<Plug>VimspectorBalloonEval", opt)
end


-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n" }, "<leader>to", toggleterm.toggleB)
  vim.keymap.set({ "n" }, "<leader>tf", toggleterm.toggleA)
  vim.keymap.set({ "n" }, "<leader>tg", toggleterm.toggleG)
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

-- 选择窗口
vim.keymap.set("n", "<leader>w", function()
    local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Run gofmt + goimport on save
-- local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   pattern = "*.go",
--   callback = function()
--    golangFormat.goimport()
--   end,
--   group = format_sync_grp,
-- })

map("n", "<leader>f", ":Format<CR>", opt)
map("n", "<leader>i", ":OR<CR>", opt)
map("n", "<C-v>f", ":Format<CR>", opt)
map("n", "<C-v>i", ":OR<CR>", opt)
map("n", "<C-a>n", ":ChatGPT<CR>", opt)
map("n", "<C-u>", ":MundoToggle<CR>", opt)
map("n", "<C-d>m", ":DiffviewOpen master<CR>", opt)
map("n", "<C-d>t", ":DiffviewOpen test<CR>", opt)
map("n", "<C-d>r", ":DiffviewOpen release<CR>", opt)
map("n", "<C-d>c", ":DiffviewClose<CR>", opt)
map("n", "<C-d>f", ":DiffviewFileHistory %<CR>", opt)
map("n", "<C-c>l", ":GitConflictListQf<CR>", opt)

map("n", "<leader>tw", ":TranslateW<CR>", opt)
map("v", "<leader>tr", ":TranslateR<CR>", opt)
map("v", "<leader>tt", ":'<,'>Translate<CR>", opt)

-- vim-fugitive git 插件

-- 工作session
-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
-- 命令行绑定
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
return pluginKeys
