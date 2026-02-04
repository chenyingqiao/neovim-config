#!/bin/bash

# 创建插件目录
mkdir -p ~/.tmux/plugins

# 安装 TPM（插件管理器）
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 安装 tmux-sensible
git clone https://github.com/tmux-plugins/tmux-sensible ~/.tmux/plugins/tmux-sensible

# 安装 tmux-power 主题
git clone https://github.com/wfxr/tmux-power ~/.tmux/plugins/tmux-power

# 安装 tmux-fzf-url
git clone https://github.com/wfxr/tmux-fzf-url ~/.tmux/plugins/tmux-fzf-url

# 安装 tmux-net-speed
git clone https://github.com/wfxr/tmux-net-speed ~/.tmux/plugins/tmux-net-speed

# 安装 tmux-web-reachable
git clone https://github.com/wfxr/tmux-web-reachable ~/.tmux/plugins/tmux-web-reachable

# 安装 tmux-open-nvim
git clone https://github.com/trevarj/tmux-open-nvim ~/.tmux/plugins/tmux-open-nvim

# 安装 vim-tmux-navigator
git clone https://github.com/christoomey/vim-tmux-navigator ~/.tmux/plugins/vim-tmux-navigator

echo "所有插件已手动安装完成！"

