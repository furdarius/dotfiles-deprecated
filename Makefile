CWD=$(shell pwd)

all: terminal git neovim zsh

terminal:
	sudo pacman -Syu terminator
	rm -rf $(HOME)/.config/terminator
	ln -s $(CWD)/terminator $(HOME)/.config/terminator

neovim:
	sudo pacman -Syu python2-neovim python-neovim neovim
	rm -rf $(HOME)/.config/nvim/
	mkdir -p $(HOME)/.config/nvim/
	ln -s $(CWD)/init.vim $(HOME)/.config/nvim/init.vim
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git:
	rm -rf $(HOME)/.gitconfig
	ln -s $(CWD)/.gitconfig $(HOME)/.gitconfig
	ln -s $(CWD)/.gitignore_global $(HOME)/.gitignore_global

zsh:
	rm -rf $(HOME)/.zsh_profile
	rm -rf $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_aliases $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_profile $(HOME)/.zsh_profile
	echo "source ~/.zsh_aliases" >> $(HOME)/.zshrc
	echo "source ~/.zsh_profile" >> $(HOME)/.zshrc
	sed -i 's/robbyrussell/agnoster/g' $(HOME)/.zshrc
	# xclip used to copy output to clipboard. e.g. cat file | xclip -sel clip
	sudo pacman -Syu xclip

.PHONY: terminal git neovim zsh
