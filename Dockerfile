FROM ubuntu

WORKDIR /root/download
COPY . /root/.config/nvim/
COPY .tmux.conf /root/.tmux.conf

# 更新ubuntu源
RUN apt-get update
RUN apt-get install -y curl wget git unzip zsh
RUN apt-get install -y python3 pip
RUN apt-get install -y tmux
RUN pip install neovim

# 切换shell为zsh
SHELL ["/bin/zsh", "-c"]

# 安装zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)"
RUN echo "plugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting zsh-z)" >> /root/.zshrc
RUN echo "ZSH_THEME=\"edvardm\"" >> /root/.zshrc

# 安装字体
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CodeNewRoman.zip
RUN unzip CodeNewRoman.zip
RUN mkdir -p /usr/share/fonts/CodeNewRoman
RUN mv CodeNewRomanNerd* /usr/share/fonts/CodeNewRoman 
RUN chmod 744 /usr/share/fonts/CodeNewRoman


# 设置环境变量
RUN mkdir /root/.local/
RUN echo "export PATH=/root/.local/bin:$PATH" >> /root/.zshrc
RUN echo "export LD_LIBRARY_PATH=/root/.local/lib:$LD_LIBRARY_PATH" >> /root/.zshrc
RUN echo "export SHARE_PATH=/root/.local:$SHARE_PATH" >> /root/.zshrc
RUN echo "export MANPATH=/root/.local:$MANPATH" >> /root/.zshrc
RUN source /root/.zshrc
ENV PATH="/root/.local/bin:$PATH"
ENV LD_LIBRARY_PATH="/root/.local/lib:$LD_LIBRARY_PATH" 
ENV SHARE_PATH="/root/.local/share:$SHARE_PATH" 

# 安装nodejs
RUN wget https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
RUN tar -xf node-v18.16.0-linux-x64.tar.xz
RUN cp -r node-v18.16.0-linux-x64/* ~/.local/

# 安装neovim
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar -zxvf nvim-linux64.tar.gz
RUN cp -r nvim-linux64/. /root/.local/
RUN nvim -c ":CocInstall coc-go coc-pyright" -c ":CocCommand go.install.tools" -c ":VimspectorInstall delve" -c ":VimspectorInstall debugpy" -c ":qa" 

# 安装golang
RUN wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
RUN tar -zxvf go1.20.5.linux-amd64.tar.gz
RUN cp -r ./go/. /root/.local/
RUN go install github.com/go-delve/delve/cmd/dlv@latest

CMD ["nvim"]
