if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'morhetz/gruvbox'
	Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
	Plug 'nvim-tree/nvim-tree.lua' " 文件树插件
  Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' } " 打开文件标签页
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " vscode 提示插件
  Plug 'nvim-lua/plenary.nvim' " 
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' } " 全局搜索插件
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 折叠插件 
  Plug 'puremourning/vimspector' " debug工具
  Plug 'tanvirtin/vgit.nvim'
  Plug 'ggandor/leap.nvim'
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " 浮动窗口
  Plug 'numToStr/Comment.nvim' " 注释 ctrl+/ 
  Plug 'mg979/vim-visual-multi', {'branch': 'master'} " 多行编辑 v模式 ctrl+n
  Plug 'tpope/vim-repeat' 
  Plug 'ggandor/flit.nvim' " 快捷跳转
  Plug 'lewis6991/gitsigns.nvim' " git差异显示和提交信息显示
  Plug 'ahmedkhalf/project.nvim' " 项目管理
  Plug 'glepnir/dashboard-nvim' " 标题画面 
  Plug 's1n7ax/nvim-window-picker' " 窗口选择
  " 主题
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
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
lua require('plugin-config/windows-picker')
" lua require('plugin-config/dashboard')
" lua require('plugin-config/project')



