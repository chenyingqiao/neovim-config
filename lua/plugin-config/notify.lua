-- 确保启用真彩色
vim.opt.termguicolors = true

-- 安装插件后，调用 setup 进行配置
require("notify").setup({
  -- 渲染风格：可选 "default", "minimal", "simple", "compact", "wrapped-compact"
  render = "default",

  -- 动画风格：可选 "fade_in_slide_out", "fade", "slide", "static"
  stages = "fade_in_slide_out",

  -- 默认超时时间（毫秒），false 表示不自动关闭
  timeout = 10000,

  -- 通知显示的最大高度（行数），超出会滚动
  max_height = function()
    return math.floor(vim.o.lines * 0.5)
  end,

  -- 通知显示的最大宽度（列数），超出会换行
  max_width = function()
    return math.floor(vim.o.columns * 0.5)
  end,

  -- 背景色，可以是高亮组名（如 "Normal"）或颜色代码（如 "#000000"）
  background_colour = "#000000",

  -- 自定义图标（需要 Nerd Font 支持）
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },

  -- 窗口层级，防止被其他浮动窗口覆盖
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { zindex = 100 })
  end,
})

-- 重要：将 vim.notify 替换为 nvim-notify，使其他插件（如 LSP）也使用此样式
vim.notify = require("notify")

-- 可选：配置 Telescope 扩展以查看历史通知
-- 确保已安装 telescope.nvim
local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.load_extension("notify")
end
