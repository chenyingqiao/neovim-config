# Neovim配置文件

主要是自用的配置，可以在 nvim 中使用

## 安装
克隆本项目到 `~/.config/nvim` 目录下
在 nvim 中运行 `:PlugInstall` 安装插件
关联的一些依赖软件：

git
lazygit
fzf
python3
python3-pip
nodejs
curl
wget
git
unzip
zsh
fd-find
ripgrep


# 快捷键

# Vim 快捷键列表

| Vim 模式              | 快捷键                | 功能                                   |
|-----------------------|-----------------------|----------------------------------------|
| 普通模式 (n)          | `<leader>s`           | 保存文件                               |
| 普通模式 (n)          | `<leader>wq`          | 保存并退出所有文件                     |
| 普通模式 (n)          | `j`                   | 向下移动，支持换行                     |
| 普通模式 (n)          | `k`                   | 向上移动，支持换行                     |
| 普通模式 (n)          | `<C-j>`               | 向下滚动 15 行                         |
| 普通模式 (n)          | `<C-k>`               | 向上滚动 15 行                         |
| 普通模式 (n)          | `/`                   | 开始魔法搜索                           |
| 普通模式 (n)          | `zz`                  | 折叠关闭（treesitter）                |
| 普通模式 (n)          | `Z`                   | 折叠展开（treesitter）                |
| 普通模式 (n)          | `<leader>fk`          | 切换 NvimTree                         |
| 普通模式 (n)          | `<leader>fj`          | 聚焦 NvimTree                          |
| 普通模式 (n)          | `<leader>h`           | 移动到左边窗口                        |
| 普通模式 (n)          | `<leader>j`           | 移动到底部窗口                        |
| 普通模式 (n)          | `<leader>k`           | 移动到顶部窗口                        |
| 普通模式 (n)          | `<leader>l`           | 移动到右边窗口                        |
| 普通模式 (n)          | `sv`                  | 垂直分屏                              |
| 普通模式 (n)          | `ss`                  | 水平分屏                              |
| 普通模式 (n)          | `sc`                  | 关闭当前窗口                          |
| 普通模式 (n)          | `so`                  | 关闭其他所有窗口                      |
| 普通模式 (n)          | `<leader>qq`          | 不保存并退出所有文件                  |
| 普通模式 (n)          | `<leader>xl`          | 关闭左侧标签页                        |
| 普通模式 (n)          | `<leader>xr`          | 关闭右侧标签页                        |
| 普通模式 (n)          | `<leader>xo`          | 关闭其他标签页                        |
| 普通模式 (n)          | `<leader>xx`          | 关闭当前标签页                        |
| 普通模式 (n)          | `<C-p>`               | 打开 Telescope 查找文件               |
| 普通模式 (n)          | `<leader>ff`          | 打开 Telescope 查找文件               |
| 普通模式 (n)          | `<leader>fg`          | 打开 Telescope 实时搜索               |
| 普通模式 (n)          | `<leader>fb`          | 打开 Telescope 缓存文件               |
| 普通模式 (n)          | `<leader>fr`          | 打开 Telescope 搜索字符串             |
| 普通模式 (n)          | `<leader>fib`         | 打开 Telescope git 分支               |
| 普通模式 (n)          | `<leader>fis`         | 打开 Telescope git 状态               |
| 普通模式 (n)          | `<leader>fit`         | 打开 Telescope git stash              |
| 普通模式 (n)          | `<leader>f`           | 格式化代码                             |
| 普通模式 (n)          | `<leader>i`           | 执行其他操作                           |
| 普通模式 (n)          | `<C-v>f`              | 格式化代码                             |
| 普通模式 (n)          | `<C-v>i`              | 执行其他操作                           |
| 普通模式 (n)          | `<C-a>n`              | 打开 ChatGPT                           |
| 普通模式 (n)          | `<C-u>`               | 切换 Mundo 视图                        |
| 普通模式 (n)          | `<C-d>m`              | 打开 Diffview master 分支             |
| 普通模式 (n)          | `<C-d>t`              | 打开 Diffview test 分支               |
| 普通模式 (n)          | `<C-d>r`              | 打开 Diffview release 分支            |
| 普通模式 (n)          | `<C-d>c`              | 关闭 Diffview                          |
| 普通模式 (n)          | `<C-d>f`              | 查看 Diffview 文件历史                |
| 普通模式 (n)          | `<C-c>l`              | 打开 GitConflict 列表                  |
| 普通模式 (n)          | `<leader>tw`          | 翻译当前单词（使用翻译命令 'w'）      |
| 可视模式 (v)          | `<leader>tr`          | 翻译当前选中文本（使用翻译命令 'r'）  |
| 可视模式 (v)          | `<leader>tt`          | 翻译选中的块                          |
| 可视模式 (v)          | `<`                   | 减少缩进并重新选择                    |
| 可视模式 (v)          | `>`                   | 增加缩进并重新选择                    |
| 可视模式 (v)          | `<M-Down>`            | 移动选中文本向下                      |
| 可视模式 (v)          | `<M-Up>`              | 移动选中文本向上                      |
| 可视模式 (v)          | `p`                   | 粘贴内容但不覆盖选区                  |
| 插入模式 (i)          | `<C-h>`               | 光标向左移动                           |
| 插入模式 (i)          | `<C-l>`               | 光标向右移动                           |
| 插入模式 (i)          | `<C-j>`               | 光标向下移动                           |
| 插入模式 (i)          | `<C-k>`               | 光标向上移动                           |
| 插入模式 (i)          | `<C-e>`               | 光标跳到行尾                           |
| 插入模式 (i)          | `<C-b>`               | 光标跳到行首                           |
| 终端模式 (t)          | `<Esc>`               | 切换回普通模式                         |
| 终端模式 (t)          | `<M-h>`               | 切换到终端左侧窗口                    |
| 终端模式 (t)          | `<M-j>`               | 切换到终端底部窗口                    |
| 终端模式 (t)          | `<M-k>`               | 切换到终端顶部窗口                    |
| 终端模式 (t)          | `<M-l>`               | 切换到终端右侧窗口                    |
| 命令模式 (c)          | `:`                   | 打开 FineCmdline                       |
| 普通模式 (n) / 可视模式 (v) | `gcc`                 | 行注释切换                               |
| 普通模式 (n) / 可视模式 (v) | `gbc`                 | 块注释切换                               |
| 普通模式 (n)           | `gc`                  | 行注释 (操作符等待)                       |
| 普通模式 (n)           | `gb`                  | 块注释 (操作符等待)                       |
| 普通模式 (n)           | `gcO`                 | 在当前行上方添加注释                       |
| 普通模式 (n)           | `gco`                 | 在当前行下方添加注释                       |
| 普通模式 (n)           | `gcA`                 | 在当前行末尾添加注释                     |
| 普通模式 (n) / 可视模式 (v) | `g>`                  | 扩展：增加缩进级别                         |
| 普通模式 (n) / 可视模式 (v) | `g<`                  | 扩展：减少缩进级别                         |
| 普通模式 (n) / 可视模式 (v) | `g>[count]{motion}` | 扩展：增加指定范围内的缩进级别             |
| 普通模式 (n) / 可视模式 (v) | `g<[count]{motion}` | 扩展：减少指定范围内的缩进级别             |


# 插件列表

## 主题与界面美化
- **morhetz/gruvbox**：提供了一个美观的配色方案。
- **catppuccin/nvim**：提供了一个现代化的配色方案。
- **xiyaowong/transparent.nvim**：实现透明主题效果。
- **nvim-tree/nvim-web-devicons**：为文件图标提供支持。
- **nvim-lualine/lualine.nvim**：提供了一个高度可定制的状态行。
- **nvim-telescope/telescope.nvim**：提供了一个强大的全局搜索插件。
- **nvim-telescope/telescope-file-browser.nvim**：为 Telescope 提供文件浏览器功能。
- **nvim-telescope/telescope-project.nvim**：为 Telescope 提供项目管理功能。
- **nvim-lua/plenary.nvim**：提供了一些 Lua 工具函数，常用于插件开发。
- **akinsho/bufferline.nvim**：提供了一个美观的缓冲区标签页。
- **akinsho/toggleterm.nvim**：提供了一个浮动终端窗口。
- **numToStr/Comment.nvim**：提供了一个快捷键注释插件。
- **mg979/vim-visual-multi**：提供了一个多行编辑功能。
- **tpope/vim-repeat**：提供了一个重复命令的功能。
- **ggandor/flit.nvim**：提供了一个快捷跳转功能。
- **lewis6991/gitsigns.nvim**：提供了一个 Git 差异显示和提交信息显示功能。
- **s1n7ax/nvim-window-picker**：提供了一个窗口选择功能。
- **ray-x/guihua.lua**：提供了一些 GUI 相关的功能。
- **folke/noice.nvim**：提供了一个通知系统。
- **rcarriga/nvim-notify**：提供了一个通知系统。
- **folke/persistence.nvim**：提供了一个会话管理功能。
- **VonHeikemen/fine-cmdline.nvim**：提供了一个命令行增强功能。
- **jiangmiao/auto-pairs**：提供了一个自动配对功能。
- **echasnovski/mini.nvim**：提供了一些小型工具函数。
- **LunarVim/bigfile.nvim**：提供了一个大文件优化功能。
- **tpope/vim-fugitive**：提供了一个 Git 集成功能。
- **glepnir/dashboard-nvim**：提供了一个启动页功能。
- **simnalamburt/vim-mundo**：提供了一个撤销树功能。
- **karb94/neoscroll.nvim**：提供了一个平滑滚动功能。
- **MunifTanjim/nui.nvim**：提供了一些 UI 组件。
- **moll/vim-bbye**：提供了一个关闭缓冲区的功能。
- **akinsho/git-conflict.nvim**：提供了一个 Git 冲突解决功能。
- **folke/indent-blankline.nvim**：提供了一个缩进线显示功能。
- **sindrets/diffview.nvim**：提供了一个 Git 差异查看功能。
- **kylechui/nvim-surround**：提供了一个环绕操作功能。
- **Pocco81/auto-save.nvim**：提供了一个自动保存功能。
- **tanvirtin/vgit.nvim**：提供了一个 Git 集成功能。
- **ggandor/leap.nvim**：提供了一个快捷跳转功能。
- **voldikss/vim-translator**：提供了一个翻译功能。
- **iamcco/markdown-preview.nvim**：提供了一个 Markdown 预览功能。
- **robitx/gp.nvim**：提供了一个 Git 集成功能。
- **supermaven-inc/supermaven-nvim**：提供了一个 Maven 集成功能。
- **stevearc/dressing.nvim**：提供了一些 UI 组件。
- **MunifTanjim/nui.nvim**：提供了一些 UI 组件。
- **MeanderingProgrammer/render-markdown.nvim**：提供了一个 Markdown 渲染功能。
- **hrsh7th/nvim-cmp**：提供了一个代码补全功能。
- **echasnovski/mini.icons**：提供了一些图标。
- **HakonHarnes/img-clip.nvim**：提供了一个图片剪切板功能。
- **zbirenbaum/copilot.lua**：提供了一个代码补全功能。
- **yetone/avante.nvim**：提供了一个主题。
- **kawre/leetcode.nvim**：提供了一个 LeetCode 集成功能。

## 代码编辑与开发
- **nvim-treesitter/nvim-treesitter**：提供了一个代码高亮和语法分析功能。
- **nvim-lspconfig**：提供了一个语言服务器协议配置功能。
- **neoclide/coc.nvim**：提供了一个代码补全和语言服务器协议集成功能。
- **puremourning/vimspector**：提供了一个调试工具。
- **nvim-tree/nvim-tree.lua**：提供了一个文件树功能。
- **nvim-telescope/telescope.nvim**：提供了一个全局搜索功能。
- **nvim-telescope/telescope-file-browser.nvim**：提供了一个文件浏览器功能。
- **nvim-telescope/telescope-project.nvim**：提供了一个项目管理功能。
- **nvim-lua/plenary.nvim**：提供了一些 Lua 工具函数。
- **akinsho/bufferline.nvim**：提供了一个缓冲区标签页功能。
- **akinsho/toggleterm.nvim**：提供了一个浮动终端窗口功能。
- **numToStr/Comment.nvim**：提供了一个快捷键注释功能。
- **mg979/vim-visual-multi**：提供了一个多行编辑功能。
- **tpope/vim-repeat**：提供了一个重复命令功能。
- **ggandor/flit.nvim**：提供了一个快捷跳转功能。
- **lewis6991/gitsigns.nvim**：提供了一个 Git 差异显示和提交信息显示功能。
- **s1n7ax/nvim-window-picker**：提供了一个窗口选择功能。
- **ray-x/guihua.lua**：提供了一些 GUI 相关的功能。
- **folke/noice.nvim**：提供了一个通知系统功能。
- **rcarriga/nvim-notify**：提供了一个通知系统功能。
- **folke/persistence.nvim**：提供了一个会话管理功能。
- **VonHeikemen/fine-cmdline.nvim**：提供了一个命令行增强功能。
- **jiangmiao/auto-pairs**：提供了一个自动配对功能。
- **echasnovski/mini.nvim**：提供了一些小型工具函数。
- **LunarVim/bigfile.nvim**：提供了一个大文件优化功能。
- **tpope/vim-fugitive**：提供了一个 Git 集成功能。
- **glepnir/dashboard-nvim**：提供了一个启动页功能。
- **simnalamburt/vim-mundo**：提供了一个撤销树功能。
- **karb94/neoscroll.nvim**：提供了一个平滑滚动功能。
- **MunifTanjim/nui.nvim**：提供了一些 UI 组件。
- **moll/vim-bbye**：提供了一个关闭缓冲区功能。
- **akinsho/git-conflict.nvim**：提供了一个 Git 冲突解决功能。
- **folke/indent-blankline.nvim**：提供了一个缩进线显示功能。
- **sindrets/diffview.nvim**：提供了一个 Git 差异查看功能。
- **kylechui/nvim-surround**：提供了一个环绕操作功能。
- **Pocco81/auto-save.nvim**：提供了一个自动保存功能。
- **tanvirtin/vgit.nvim**：提供了一个 Git 集成功能。
- **ggandor/leap.nvim**：提供了一个快捷跳转功能。
- **voldikss/vim-translator**：提供了一个翻译功能。
- **iamcco/markdown-preview.nvim**：提供了一个 Markdown 预览功能。
- **robitx/gp.nvim**：提供了一个 Git 集成功能。
- **supermaven-inc/supermaven-nvim**：提供了一个 Maven 集成功能。
- **stevearc/dressing.nvim**：提供了一些 UI 组件。
- **MunifTanjim/nui.nvim**：提供了一些 UI 组件。
- **MeanderingProgrammer/render-markdown.nvim**：提供了一个 Markdown 渲染功能。
- **hrsh7th/nvim-cmp**：提供了一个代码补全功能。
- **echasnovski/mini.icons**：提供了一些图标。
- **HakonHarnes/img-clip.nvim**：提供了一个图片剪切板功能。
- **zbirenbaum/copilot.lua**：提供了一个代码补全功能。
- **yetone/avante.nvim**：提供了一个主题。
- **kawre/leetcode.nvim**：提供了一个 LeetCode 集成功能。


# 关于 coc.preferences.jumpCommand
edit: 使用 :edit 命令打开文件，这是默认的行为，会替换当前窗口的内容。
split: 使用 :split 命令在新的水平分割窗口中打开文件。
vsplit: 使用 :vsplit 命令在新的垂直分割窗口中打开文件。
tabedit: 使用 :tabedit 命令在新的标签页中打开文件。
drop: 这是一个特殊的值，表示使用 Vim 的 :drop 命令，它会在当前窗口中打开文件，但保持当前光标位置不变。
buffer: 尝试在已有的缓冲区中打开文件，如果缓冲区不存在，则使用 edit 命令。
quickfix: 将跳转目标添加到快速修复列表中，然后使用 :copen 打开快速修复窗口。
location: 将跳转目标添加到位置列表中，然后使用 :lopen 打开位置列表窗口。
pedit: 使用 :pedit 命令打开预览窗口，适用于查看文件的一部分内容。
new: 尝试在新的缓冲区中打开文件，如果缓冲区已存在，则不打开新窗口。
lcd: 更改当前 Vim 会话的工作目录到跳转目标的目录。
tcd: 同 lcd，但用于终端缓冲区。



