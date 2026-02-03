FROM hub.rat.dev/ubuntu

WORKDIR /root/download
COPY . /root/.config/nvim/
COPY .tmux.conf /root/.tmux.conf

# 更新ubuntu源
RUN apt-get update
RUN apt-get install -y curl wget git unzip zsh autojump
RUN apt-get install -y python3 pip
RUN apt-get install -y tmux
RUN apt-get install -y fd-find ripgrep fzf
RUN pip install --break-system-packages neovim
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v0.58.1/lazygit_0.58.1_Linux_x86_64.tar.gz"
RUN curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh  | sh
RUN tar xf lazygit.tar.gz lazygit
RUN install lazygit /usr/local/bin

# 安装 oh-my-zsh（手动克隆，更可靠）
RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && break || (sleep 10 && git clone ${GH_PROXY}/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh); \
    done

# 安装插件（使用镜像）
RUN mkdir -p ~/.oh-my-zsh/custom/plugins

RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && break || (sleep 10 && git clone ${GH_PROXY}/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions); \
    done

RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && break || (sleep 10 && git clone ${GH_PROXY}/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting); \
    done

RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z && break || (sleep 10 && git clone ${GH_PROXY}/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z); \
    done

# 直接创建 .zshrc 配置文件
COPY .zshrc /root/.zshrc

# 切换shell为zsh
SHELL ["/bin/zsh", "-c"]

# 安装字体
ADD CodeNewRoman.zip ./
RUN unzip CodeNewRoman.zip
RUN mkdir -p /usr/share/fonts/CodeNewRoman
RUN mv CodeNewRomanNerd* /usr/share/fonts/CodeNewRoman 
RUN chmod 744 /usr/share/fonts/CodeNewRoman


# 设置环境变量
RUN mkdir /root/.local/
# RUN source /root/.zshrc
ENV PATH="/root/.local/bin:/root/go/bin:$PATH"
ENV LD_LIBRARY_PATH="/root/.local/lib"
ENV SHARE_PATH="/root/.local/share"
ENV MANPATH="/root/.local/man"

# 安装nodejs
RUN wget https://nodejs.org/dist/v25.5.0/node-v25.5.0-linux-x64.tar.xz
RUN tar -xf node-v25.5.0-linux-x64.tar.xz
RUN cp -r node-v25.5.0-linux-x64/* ~/.local/

# 安装claudecode
RUN npm install -g @anthropic-ai/claude-code

# 配置claudecode (通过环境变量传入敏感信息)
RUN mkdir -p ~/.claude && \
    echo "{\"env\":{\"ANTHROPIC_AUTH_TOKEN\":\"\",\"ANTHROPIC_BASE_URL\":\"\"},\"enabledPlugins\":{\"gopls-lsp@claude-plugins-official\":true,\"php-lsp@claude-plugins-official\":true},\"alwaysThinkingEnabled\":true}" > ~/.claude/settings.json

# 安装neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz
RUN tar -zxvf nvim-linux-x86_64.tar.gz
RUN cp -r  nvim-linux-x86_64/. /root/.local/

# 安装golang
RUN wget https://go.dev/dl/go1.25.6.linux-amd64.tar.gz
RUN tar -zxvf go1.25.6.linux-amd64.tar.gz
RUN cp -r ./go/. /root/.local/
RUN go env -w  GOPROXY=https://goproxy.cn,direct
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install golang.org/x/tools/gopls@latest

RUN chsh -s $(which zsh)

CMD ["sleep", "infinity"]
