set nocompatible
set mouse=v
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set expandtab 
set shiftwidth=4
set autoindent
set number 
set wildmode=longest,list
set cc=80
filetype plugin indent on
syntax on
set mouse=a 
set clipboard=unnamedplus
filetype plugin on
set cursorline 
set ttyfast

lua require('setup')
lua require('config.lazy')

let g:vimtex_view_method = 'zathura'
" let g:vimtex_compiler_method = 'latexrun'

