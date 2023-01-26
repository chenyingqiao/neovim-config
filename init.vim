if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'morhetz/gruvbox'
	Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
	Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
  Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'puremourning/vimspector'
  Plug 'nvim-lua/plenary'
  Plug 'tanvirtin/vgit'
  " 主题
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

lua require('basic')
lua require('plugin-config/coc')
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')

lua require('theme')
lua require('keybinding')

set statusline+=%{get(b:,'vgit_status','')}
