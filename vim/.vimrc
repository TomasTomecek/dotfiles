" Use Vim defaults (much better!)
set nocompatible

filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'rust-lang/rust.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jwhitley/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-sensible'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Shougo/neocomplete.vim'
Plugin 'kien/ctrlp.vim'

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

silent !mkdir -p $HOME/.vim/swapfiles/ > /dev/null 2>&1
set directory=$HOME/.vim/swapfiles//
silent !mkdir -p $HOME/.vim/undofiles/ > /dev/null 2>&1
set undodir=$HOME/.vim/undofiles//
set undofile

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256 "256
colorscheme solarized

nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
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
" let g:syntastic_pylint_exec = '/usr/bin/python3-pylint'
" let g:syntastic_python_pylint_exec = '/usr/bin/python3-pylint'

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
" when completing python, don't insert completion automatically
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0

set list

" airline
let g:airline#extensions#tabline#enabled = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
autocmd FileType gitcommit setlocal spell spelllang=en
autocmd FileType \(sh\|yaml\|javscript\) setlocal shiftwidth=2
autocmd FileType \(sh\|yaml\|javscript\) setlocal tabstop=2
autocmd FileType mail setlocal textwidth=80
autocmd FileType mail setlocal spell spelllang=en
autocmd FileType go setlocal nolist  " go uses /t
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Don't save backups of *.gpg files
set backupskip+=*.gpg

augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "%!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END

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
