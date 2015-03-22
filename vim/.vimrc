" Use Vim defaults (much better!)
set nocompatible

filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jwhitley/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-sensible'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/neocomplete.vim'

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
"don't complain when changing buffers via :buffer
set hidden

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256 "256
colorscheme solarized

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" checks take too long: let's run them adhoc with :SyntasticCheck
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_args = '--rcfile=/home/ttomecek/.pylintrc'
let g:syntastic_mode_map = {"mode": "passive"}
let g:syntastic_python_checkers = ["pylint"]

" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" easymotion
imap <C-F>w <C-o><leader><leader>w
imap <C-F>F <C-o><leader><leader>F
imap <C-F>f <C-o><leader><leader>f

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
