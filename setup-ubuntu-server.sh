#!/bin/bash

(git submodule init && git submodule sync && git submodule update) &

(cd ~ && ln -sf git/dotfile/{.ctags,.cvsrc,.emacs,.gitattributes_global,.gitignore_global,.tmux.conf,.vimrc,.zshrc,.fzf} .)

(yes | .fzf/install)&
mkdir -p ~/tmp

git config --global --replace-all color.ui true
git config --global --replace-all core.excludesfile ~/.gitignore_global
git config --global --replace-all core.attributesfile ~/.gitattributes_global

(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) &

wait
