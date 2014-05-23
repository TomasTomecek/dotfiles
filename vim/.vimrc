" execute pathogen#infect()

" Use Vim defaults (much better!)
set nocompatible

filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'

" allow backspacing over everything in insert mode
set bs=indent,eol,start		

" autoindent on
set ai
set tabstop=4
set shiftwidth=4

set history=250

set backupdir=/var/tmp

set ruler
set number

set ignorecase
set smartcase

set expandtab 
syntax enable
set background=dark
"syntax on
set hlsearch
filetype indent plugin on
filetype plugin on
set modeline
set pastetoggle=<F2>
set showmode

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=16 "256
colorscheme solarized

set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/

let g:Powerline_theme='short'
let g:Powerline_colorscheme='skwp'
let g:Powerline_theme='skwp'

" get rid of annoying <esc> timeout
set ttimeoutlen=100
"set noesckeys

" Always show statusline
set laststatus=2


if has("autocmd")
  augroup fedora
  autocmd!
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

