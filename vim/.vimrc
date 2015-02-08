" Use Vim defaults (much better!)
set nocompatible

filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-sensible'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'

call vundle#end()

set tabstop=4
set shiftwidth=4
set expandtab

set history=250

set backupdir=/var/tmp

set number

set ignorecase
set smartcase

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
set t_Co=256 "256
colorscheme solarized

"set noesckeys

if has("autocmd")
  augroup fedora
  autocmd!
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END

  augroup generic
  autocmd!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END
endif
