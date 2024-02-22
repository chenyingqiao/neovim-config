#!/bin/bash

# 安装zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# clone配置
git clone https://github.com/chenyingqiao/neovim-config.git ~/.config/nvim

# 安装.local/
apt-get update;
apt-get install -y curl wget git unzip zsh;
apt-get install -y python3 pip;
apt-get install -y tmux;
pip install neovim;
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz";
tar xf lazygit.tar.gz lazygit;
install lazygit /usr/local/bin;

# 安装字体
unzip CodeNewRoman.zip
mkdir -p /usr/share/fonts/CodeNewRoman
mv CodeNewRomanNerd* /usr/share/fonts/CodeNewRoman
chmod 744 /usr/share/fonts/CodeNewRoman
mkdir /root/.local/

# 设置环境变量
cat <<'EOF'  >> ~/.zshrc
PATH="/root/.local/bin:/root/go/bin:$PATH"
LD_LIBRARY_PATH="/root/.local/lib:$LD_LIBRARY_PATH"
SHARE_PATH="/root/.local/share:$SHARE_PATH"
MANPATH="/root/.local/man:$MANPATH"
EOF

# 安装node
wget https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
tar -xf node-v18.16.0-linux-x64.tar.xz
cp -r node-v18.16.0-linux-x64/* ~/.local/

# 安装nvim
wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
cp -r nvim-linux64/. ~/.local/

# 安装golang
wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
tar -zxvf go1.20.5.linux-amd64.tar.gz
cp -r ./go/. /root/.local/
go env -w  GOPROXY=https://goproxy.cn,direct
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest

# 安装插件
nvim --noplugin --headless -c "PlugInstall"
nvim --noplugin -c "TSUpdate"
nvim --noplugin -c "CocInstall coc-go coc-pyright"
nvim --noplugin -c "CocCommand go.install.tools"
nvim --noplugin -c "VimspectorInstall delve"
nvim --noplugin -c "VimspectorInstall debugpy"
