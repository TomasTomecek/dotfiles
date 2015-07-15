#!/bin/bash

which git 2>/dev/null || { echo "Can't find git binary." && exit 1 ; }
which stow 2>/dev/null || { echo "Can't find stow binary." && exit 1 ; }

mkdir -p ~/.dotfiles/
mkdir -p ~/.vim/bundle/

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/TomasTomecek/dotfiles.git ~/.dotfiles/

cd ~/.dotfiles/

git submodule init
git submodule update

# back up .bashrc
mv ~/.bashrc ~/.bashrc.bkp || :

stow -v 2 tmux zsh bash vim ipython git

vim +PluginInstall +qall
