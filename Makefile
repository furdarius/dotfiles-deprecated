CWD=$(shell pwd)
BINDIR=$(HOME)/bin

all: vim git bash

vim: 
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.config/nvim/init.vim
	ln -s $(HOME)/.vim $(HOME)/.config/nvim
	ln -s $(CWD)/.vimrc $(HOME)/.vimrc
	ln -s $(CWD)/.vimrc $(HOME)/.config/nvim/init.vim

git: 
	rm -rf $(HOME)/.gitconfig
	ln -s $(CWD)/.gitconfig $(HOME)/.gitconfig

bash:
	rm -rf $(HOME)/.bash_profile
	rm -rf $(HOME)/.bash_aliases
	ln -s $(CWD)/.bash_aliases $(HOME)/.bash_aliases
	ln -s $(CWD)/.bash_profile $(HOME)/.bash_profile

.PHONY: vim git bash
