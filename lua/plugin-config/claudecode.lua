require('claudecode').setup({
-- 服务器配置
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info", -- "trace", "debug", "info", "warn", "error"
    terminal_cmd = nil, -- 自定义终端命令（默认："claude"）
                        -- 本地安装使用："~/.claude/local/claude"
                        -- 原生二进制文件：使用 'which claude' 的输出结果

    -- 发送/焦点行为
    -- 设置为 true 时，如果已经连接，成功发送后将聚焦到 Claude 终端
    focus_after_send = false,

    -- 选择跟踪
    track_selection = true,
    visual_demotion_delay_ms = 50,

    -- 终端配置
    terminal = {
      split_side = "right", -- "left" 或 "right"
      split_width_percentage = 0.30,
      provider = "auto", -- "auto", "snacks", "native", "external", "none" 或自定义提供者表格
      auto_close = true,
      snacks_win_opts = {}, -- 传递给 `Snacks.terminal.open()` 的选项 - 参见下方的浮动窗口部分

      -- 提供者特定选项
      provider_opts = {
        -- 外部终端提供者命令。可以是：
        -- 1. 带有 %s 占位符的字符串："alacritty -e %s"（向后兼容）
        -- 2. 带有两个 %s 占位符的字符串："alacritty --working-directory %s -e %s"（工作目录，命令）
        -- 3. 返回命令的函数：function(cmd, env) return "alacritty -e " .. cmd end
        external_terminal_cmd = nil,
      },
    },

    -- 差异集成
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true,
      open_in_current_tab = true,
      keep_terminal_focus = false, -- 如果为 true，差异窗口打开后将焦点移回终端
    },
})
