#!/bin/bash

mkdir -p $HOME/.local/
# 安装zsh
echo "安装zsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装.local/
if [ ! -e $HOME/bin/lazygit ]; then
echo "====================================================安装 tmux python lazygit等===================================================="
sudo apt-get update;
sudo apt-get install -y curl wget git unzip zsh;
sudo apt-get install -y python3 pip;
sudo apt-get install -y tmux;
pip install neovim;
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz";
tar xf lazygit.tar.gz lazygit;
install lazygit $HOME/bin;
fi

# tmux 配置
if [ ! -e ~/.tmux.conf ]; then
echo "====================================================tmux 配置===================================================="
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ./.tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
fi

# 安装字体
if [ ! -d /usr/share/fonts/CodeNewRoman ]; then
echo "====================================================安装字体文件===================================================="
unzip CodeNewRoman.zip
mkdir -p /usr/share/fonts/CodeNewRoman
mv CodeNewRomanNerd* /usr/share/fonts/CodeNewRoman
chmod 744 /usr/share/fonts/CodeNewRoman
fi

# 设置环境变量
echo "====================================================设置环境===================================================="
cat <<'EOF'  >> ~/.zshrc
PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
SHARE_PATH="$HOME/.local/share:$SHARE_PATH"
MANPATH="$HOME/.local/man:$MANPATH"
EOF
source ~/.zshrc

# 安装node

echo "====================================================安装node===================================================="
if [ ! -e node-v18.16.0-linux-x64.tar.xz ]; then
wget https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
fi
tar -xf node-v18.16.0-linux-x64.tar.xz
cp -r node-v18.16.0-linux-x64/* $HOME/.local/

# 安装nvim
echo "====================================================安装nvim===================================================="
if [ ! -e nvim-linux64.tar.gz ]; then
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
fi
tar -zxvf nvim-linux64.tar.gz
cp -r nvim-linux64/. $HOME/.local/
cp plug.vim $HOME/.local/share/nvim/site/autoload/

# 安装golang
echo "====================================================安装golang===================================================="
if [ ! -e go1.20.5.linux-amd64.tar.gz ]; then
wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
fi
tar -zxvf go1.20.5.linux-amd64.tar.gz
cp -r ./go/. $HOME/.local/
go env -w  GOPROXY=https://goproxy.cn,direct
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest

# 安装插件
echo "====================================================开始安装nvim插件===================================================="
nvim  --headless -c "PlugInstall"
nvim  -c "TSUpdate"
nvim  -c "CocInstall coc-go coc-pyright"
nvim  -c "CocCommand go.install.tools"
nvim  -c "VimspectorInstall delve"
nvim  -c "VimspectorInstall debugpy"
