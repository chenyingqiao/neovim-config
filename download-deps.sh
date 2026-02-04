#!/bin/bash
set -e

# 下载函数：文件存在且有效则跳过
download_if_missing() {
    local url="$1"
    local filename=$(basename "$url")
    local min_size=1000000  # 最小文件大小 1MB

    if [ -f "$filename" ]; then
        local filesize=$(stat -f%z "$filename" 2>/dev/null || stat -c%s "$filename" 2>/dev/null || echo 0)
        if [ "$filesize" -gt "$min_size" ]; then
            echo "✓ 已存在: $filename ($(numfmt --to=iec-i --suffix=B $filesize 2>/dev/null || echo ${filesize}B))"
            return 0
        else
            echo "⚠ 文件损坏或过小: $filename (${filesize}B)，重新下载"
            rm -f "$filename"
        fi
    fi

    echo "↓ 下载中: $filename"
    wget -q --show-progress "$url"
}

mkdir -p downloads/x86_64 downloads/aarch64

echo "=== 下载 x86_64 架构依赖 ==="
cd downloads/x86_64
download_if_missing https://github.com/jesseduffield/lazygit/releases/download/v0.58.1/lazygit_0.58.1_Linux_x86_64.tar.gz
download_if_missing https://nodejs.org/dist/v25.5.0/node-v25.5.0-linux-x64.tar.xz
download_if_missing https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz
download_if_missing https://go.dev/dl/go1.25.6.linux-amd64.tar.gz
download_if_missing https://github.com/Jeric-X/SyncClipboard/releases/download/v3.1.0/SyncClipboard_linux_x64.deb
cd ../..

echo "=== 下载 aarch64 架构依赖 ==="
cd downloads/aarch64
download_if_missing https://github.com/jesseduffield/lazygit/releases/download/v0.58.1/lazygit_0.58.1_Linux_arm64.tar.gz
download_if_missing https://nodejs.org/dist/v25.5.0/node-v25.5.0-linux-arm64.tar.xz
download_if_missing https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-arm64.tar.gz
download_if_missing https://go.dev/dl/go1.25.6.linux-arm64.tar.gz
download_if_missing https://github.com/Jeric-X/SyncClipboard/releases/download/v3.1.0/SyncClipboard_linux_arm64.deb
cd ../..

echo "=== 下载完成 ==="
ls -lh downloads/x86_64/
ls -lh downloads/aarch64/
