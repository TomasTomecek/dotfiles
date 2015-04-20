#!/bin/bash
mkdir -p ~/.dotfiles/
mkdir -p ~/.vim/bundle/

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/TomasTomecek/dotfiles.git ~/.dotfiles/

cd ~/.dotfiles/

git submodule init
git submodule update

stow -v 2 tmux zsh bash vim ipython git

vim +PluginInstall +qall
