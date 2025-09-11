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
	Plug 'akinsho/bufferline.nvim' " 打开文件标签页
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " vscode 提示插件
	Plug 'nvim-lua/plenary.nvim' " 
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' } " 全局搜索插件
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " 代码高亮美化
	Plug 'puremourning/vimspector' " debug工具
	Plug 'tanvirtin/vgit.nvim'
	Plug 'ggandor/leap.nvim'
	Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " 浮动窗口
	Plug 'numToStr/Comment.nvim' " 注释 ctrl+/ 
	Plug 'mg979/vim-visual-multi', {'branch': 'master'} " 多行编辑 v模式 ctrl+n
	Plug 'tpope/vim-repeat' 
	Plug 'ggandor/flit.nvim' " 快捷跳转
	Plug 'lewis6991/gitsigns.nvim' " git差异显示和提交信息显示
	Plug 's1n7ax/nvim-window-picker' " 窗口选择
	Plug 'neovim/nvim-lspconfig'
	Plug 'ray-x/guihua.lua' 
	Plug 'nvim-lualine/lualine.nvim'
	" If you want to have icons in your statusline choose one of these
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'sindrets/diffview.nvim'
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'kylechui/nvim-surround'
	Plug 'Pocco81/auto-save.nvim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'voldikss/vim-translator'	
	Plug 'glepnir/dashboard-nvim'
	Plug 'simnalamburt/vim-mundo'
	Plug 'karb94/neoscroll.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'moll/vim-bbye'
	Plug 'akinsho/git-conflict.nvim'
	Plug 'folke/persistence.nvim'
	Plug 'VonHeikemen/fine-cmdline.nvim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'rcarriga/nvim-notify'
	Plug 'folke/noice.nvim'
	Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
	Plug 'LunarVim/bigfile.nvim'
    Plug 'tpope/vim-fugitive'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

	Plug 'robitx/gp.nvim'
	Plug 'supermaven-inc/supermaven-nvim'
	
	" Deps
	Plug 'stevearc/dressing.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'MeanderingProgrammer/render-markdown.nvim'

	" Optional deps
	Plug 'hrsh7th/nvim-cmp'
	Plug 'echasnovski/mini.icons'
	Plug 'HakonHarnes/img-clip.nvim'
	Plug 'zbirenbaum/copilot.lua'

	" Yay, pass source=true if you want to build from source
	Plug 'yetone/avante.nvim', {'tag': 'v0.0.27'}

	" leetcode.nvim
	Plug 'kawre/leetcode.nvim', { 'do': ':TSUpdate html' }
	" 主题
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
	Plug 'xiyaowong/transparent.nvim'
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
lua require('plugin-config/gp')
lua require('plugin-config/supermaven')
lua require("register")
" lua require("plugin-config/dap-ui")
" lua require('plugin-config/neoscroll')
