FROM hub.rat.dev/ubuntu

ARG TARGETPLATFORM
ARG TARGETARCH

WORKDIR /root

# 安装基础工具
RUN apt-get update && \
    apt-get install -y curl wget git unzip zsh autojump python3 pip tmux fd-find ripgrep fzf x11-apps xsel xclip ca-certificates locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 复制所有架构的包
COPY downloads /tmp/downloads

# 复制配置文件
COPY . /root/.config/nvim/
COPY .tmux.conf /root/.tmux.conf
COPY .zshrc /root/.zshrc
COPY syncclipboard_client.py /root/.local/bin/syncclipboard_client.py
RUN chmod +x /root/.local/bin/syncclipboard_client.py

# 根据架构选择对应的包，直接复制到当前目录
RUN if [ "$TARGETARCH" = "amd64" ]; then \
      ARCH_DIR="x86_64"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
      ARCH_DIR="aarch64"; \
    else \
      echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi && \
    ls -la /tmp/downloads/${ARCH_DIR}/ && \
    cd /tmp/downloads/${ARCH_DIR} && \
    cp lazygit*.tar.gz node-*.tar.xz nvim-linux-*.tar.gz go*.tar.gz /root/ && \
    echo "Using ${ARCH_DIR} packages for TARGETARCH=${TARGETARCH}"

# 安装 lazygit
RUN tar xf lazygit*.tar.gz lazygit && \
    install lazygit /usr/local/bin/ && \
    rm -f lazygit*

# 安装 nodejs
RUN mkdir -p ~/.local && \
    tar -xf node-*.tar.xz && \
    cp -r node-*/* ~/.local/ && \
    rm -rf node-* node-*.tar.xz

# 安装 neovim
RUN tar -zxvf nvim-linux-*.tar.gz && \
    cp -r nvim-linux-*/* ~/.local/ && \
    rm -rf nvim-linux-* nvim-linux-*.tar.gz

# 安装 golang
RUN tar -zxvf go*.tar.gz && \
    cp -r ./go/* ~/.local/ && \
    rm -rf ./go && \
    rm -f go*.tar.gz

# 安装 Python neovim 和 SyncClipboard 客户端依赖
RUN pip install --break-system-packages neovim requests Pillow

# 生成中文 UTF-8 locale
RUN sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen zh_CN.UTF-8 && \
    update-locale LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8

# 安装 atuin
RUN curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh

# 安装 claudecode
RUN PATH="$HOME/.local/bin:$PATH" ~/.local/bin/npm install -g @anthropic-ai/claude-code

# 安装 Go 工具
RUN ~/.local/bin/go env -w GOPROXY=https://goproxy.cn,direct && \
    ~/.local/bin/go install github.com/go-delve/delve/cmd/dlv@latest && \
    ~/.local/bin/go install golang.org/x/tools/gopls@latest

# 安装 oh-my-zsh
RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && break || \
    (sleep 10 && git clone ${GH_PROXY}/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh); \
    done

# 安装插件
RUN mkdir -p ~/.oh-my-zsh/custom/plugins && \
    for i in 1 2 3 4 5; do \
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && break || \
        (sleep 10 && git clone ${GH_PROXY}/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions); \
    done

RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && break || \
        (sleep 10 && git clone ${GH_PROXY}/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting); \
    done

RUN for i in 1 2 3 4 5; do \
    git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z && break || \
        (sleep 10 && git clone ${GH_PROXY}/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z); \
    done

# 安装字体
COPY CodeNewRoman.zip ./tmp_fonts/
RUN unzip /root/tmp_fonts/CodeNewRoman.zip -d /root/tmp_fonts && \
    mkdir -p /usr/share/fonts/CodeNewRoman && \
    mv /root/tmp_fonts/CodeNewRomanNerd* /usr/share/fonts/CodeNewRoman && \
    chmod 744 /usr/share/fonts/CodeNewRoman && \
    rm -rf /root/tmp_fonts

# 设置环境变量
ENV LANG="zh_CN.UTF-8" \
    LC_ALL="zh_CN.UTF-8" \
    PATH="/root/.local/bin:/root/.local/share/npm/bin:/root/go/bin:$PATH" \
    LD_LIBRARY_PATH="/root/.local/lib" \
    SHARE_PATH="/root/.local/share" \
    MANPATH="/root/.local/man"

# 配置 claudecode
RUN mkdir -p ~/.claude && \
    echo '{"env":{"ANTHROPIC_AUTH_TOKEN":"","ANTHROPIC_BASE_URL":""},"enabledPlugins":{"gopls-lsp@claude-plugins-official":true,"php-lsp@claude-plugins-official":true},"alwaysThinkingEnabled":true}' > ~/.claude/settings.json

# 配置 tmux
COPY ./tmux-install.sh /root/tmux-install.sh
RUN chmod +x /root/tmux-install.sh
RUN /root/tmux-install.sh

# 配置neovim
RUN nvim --headless +PlugInstall +qa
# 安装 Coc 扩展
RUN nvim --headless \
    +"CocInstall \
    coc-clangd \
    coc-copilot \
    coc-go \
    coc-yaml \
    coc-groovy \
    coc-highlight \
    coc-json \
    coc-lists \
    coc-lua \
    coc-marketplace \
    coc-nav \
    coc-prettier \
    coc-protobuf \
    coc-pyright \
    coc-rls \
    coc-snippets \
    coc-tsserver" \
    +qa

# 安装 @yaegassy 的扩展（如 coc-intelephense 等）
RUN nvim --headless \
    +"CocInstall \
    @yaegassy/coc-intelephense \
    @yaegassy/coc-nginx \
    @yaegassy/coc-volar" \
    +qa

# 安装 Treesitter 语法解析器
RUN nvim --headless \
    +"TSInstall \
    python \
    json \
    javascript \
    typescript \
    lua \
    bash \
    go \
    php \
    java" \
    +qa

# 安装额外的有用解析器
RUN nvim --headless \
    +"TSInstall \
    json \
    yaml \
    toml \
    markdown \
    markdown_inline \
    dockerfile \
    make \
    css \
    html \
    scss \
    sql \
    regex \
    comment \
    query" \
    +qa

# 切换 shell
SHELL ["/bin/zsh", "-c"]
RUN chsh -s $(which zsh)

# 启动 SyncClipboard 客户端并保持容器运行
# 启动 SyncClipboard 客户端作为主进程
CMD ["python3", "/root/.local/bin/syncclipboard_client.py", "--url", "http://syncclipboard:5033", "--username", "admin", "--password", "admin", "--interval", "2"]
