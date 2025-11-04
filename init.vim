if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	" 主题和外观
	Plug 'morhetz/gruvbox' " 经典复古主题配色
	Plug 'nvim-tree/nvim-web-devicons' " 文件类型图标库
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " 现代化主题配色
	Plug 'xiyaowong/transparent.nvim' " 背景透明效果

	" 文件和界面组件
	Plug 'nvim-tree/nvim-tree.lua' " 侧边文件树管理器
	Plug 'akinsho/bufferline.nvim' " 顶部缓冲区标签栏
	Plug 'nvim-lualine/lualine.nvim' " 底部状态栏美化
	Plug 'glepnir/dashboard-nvim' " 启动界面和仪表盘

	" LSP 和代码补全
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " 智能代码补全系统
	Plug 'neovim/nvim-lspconfig' " LSP 服务器配置
	Plug 'hrsh7th/nvim-cmp' " 代码补全框架
	Plug 'zbirenbaum/copilot.lua' " GitHub Copilot AI 编码助手

	" 搜索和导航
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' } " 模糊查找器和文件搜索
	Plug 'nvim-telescope/telescope-file-browser.nvim' " 文件浏览器集成
	Plug 'nvim-telescope/telescope-project.nvim' " 项目管理器
	Plug 'ggandor/leap.nvim' " 快速光标跳跃导航
	Plug 'ggandor/flit.nvim' " 单字符跳转工具
	Plug 's1n7ax/nvim-window-picker' " 窗口选择器

	" 代码编辑增强
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 语法高亮和代码分析
	Plug 'numToStr/Comment.nvim' " 快速注释切换
	Plug 'mg979/vim-visual-multi', {'branch': 'master'} " 多光标编辑
	Plug 'tpope/vim-repeat' " 重复上一次操作
	Plug 'kylechui/nvim-surround' " 括号和引号环绕编辑
	Plug 'jiangmiao/auto-pairs' " 自动匹配括号和引号
	Plug 'lukas-reineke/indent-blankline.nvim' " 缩进指示线
	Plug 'Pocco81/auto-save.nvim' " 自动保存文件

	" Git 版本控制
	Plug 'lewis6991/gitsigns.nvim' " Git 状态显示和差异比较
	Plug 'tpope/vim-fugitive' " Git 命令集成
	Plug 'sindrets/diffview.nvim' " Git 差异视图
	Plug 'akinsho/git-conflict.nvim' " Git 冲突解决工具
	Plug 'tanvirtin/vgit.nvim' " Git 可视化工具

	" 终端和进程
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " 浮动终端窗口
	Plug 'puremourning/vimspector' " 调试器界面

	" 通知和 UI 增强
	Plug 'rcarriga/nvim-notify' " 美化的通知系统
	Plug 'folke/noice.nvim' " 命令行和消息 UI 增强
	Plug 'VonHeikemen/fine-cmdline.nvim' " 命令行输入界面

	" 工具库依赖
	Plug 'nvim-lua/plenary.nvim' " Lua 工具函数库
	Plug 'MunifTanjim/nui.nvim' " UI 组件库
	Plug 'stevearc/dressing.nvim' " UI 组件美化
	Plug 'echasnovski/mini.nvim', { 'branch': 'stable' } " 小型工具集合
	Plug 'echasnovski/mini.icons' " 图标库
	Plug 'LunarVim/bigfile.nvim' " 大文件加载优化

	" 会话和历史
	Plug 'folke/persistence.nvim' " 会话持久化保存
	Plug 'simnalamburt/vim-mundo' " 撤销树可视化
	Plug 'moll/vim-bbye' " 缓冲区管理
	Plug 'karb94/neoscroll.nvim' " 平滑滚动效果

	" Markdown 和文档
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " Markdown 实时预览
	Plug 'MeanderingProgrammer/render-markdown.nvim' " Markdown 渲染增强
	Plug '3rd/diagram.nvim' " 流程图和图表渲染
	Plug 'HakonHarnes/img-clip.nvim' " 图片粘贴支持

	" 翻译和辅助
	Plug 'voldikss/vim-translator' " 文本翻译工具
	Plug 'supermaven-inc/supermaven-nvim' " AI 代码助手

	" AI 编程助手
	Plug 'yetone/avante.nvim', {'tag': 'v0.0.27'} " AI 编码助手界面
	Plug 'coder/claudecode.nvim', { 'dependencies': ['folke/snacks.nvim'] } " Claude 集成工具
call plug#end()

lua require('basic')
lua require('plugin-config/coc')
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/toggleterm')
lua require('plugin-config/comment')
lua require('theme')
lua require('keybinding')
lua require('plugin-config/flit')
lua require('plugin-config/gitsigns')
lua require('plugin-config/vimspector')
" lua require('plugin-config/windows-picker')
lua require('plugin-config/lualine')
lua require('plugin-config/surround')
lua require('plugin-config/telescope')
lua require('plugin-config/treesitter')
lua require('plugin-config/autosave')
lua require('plugin-config/indent-blankline')
lua require('plugin-config/dashboard')
lua require('plugin-config/mundo')
lua require('plugin-config/git-conflict')
lua require('plugin-config/persistence')
lua require('plugin-config/notice')
lua require('plugin-config/minimap')
lua require('plugin-config/transparent')
lua require('plugin-config/avante')
lua require('plugin-config/supermaven')
lua require('plugin-config/claudecode')
lua require("register")
" lua require("plugin-config/dap-ui")
" lua require('plugin-config/neoscroll')
