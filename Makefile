CWD=$(shell pwd)

all: vim git bash

vim:
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.config/nvim/init.vim
	ln -s $(CWD)/.vimrc $(HOME)/.vimrc
	ln -s $(HOME)/.vimrc $(HOME)/.config/nvim/init.vim

git:
	rm -rf $(HOME)/.gitconfig
	ln -s $(CWD)/.gitconfig $(HOME)/.gitconfig

bash:
	rm -rf $(HOME)/.zsh_profile
	rm -rf $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_aliases $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_profile $(HOME)/.zsh_profile

.PHONY: vim git bash
