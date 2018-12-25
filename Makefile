CWD=$(shell pwd)

all: terminal git neovim

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
	touch $(HOME)/.gitignore_global

shell:
	# https://gist.github.com/furdarius/97bf6092104222fd36c4fd351b9264c2
	# sudo apt install zsh
	# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
	# wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
	# mv PowerlineSymbols.otf ~/.fonts/
	# fc-cache -vf ~/.fonts/
	# mkdir -p .config/fontconfig/conf.d
	# mv 10-powerline-symbols.conf $(HOME)/.config/fontconfig/conf.d/
	rm -rf $(HOME)/.zsh_profile
	rm -rf $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_aliases $(HOME)/.zsh_aliases
	ln -s $(CWD)/.zsh_profile $(HOME)/.zsh_profile
	echo "source ~/.zsh_aliases" >> $(HOME)/.zshrc \
		&& echo "source ~/.zsh_profile" >> $(HOME)/.zshrc
	sed -i 's/robbyrussell/agnoster/g' $(HOME)/.zshrc
	# sudo apt install dconf-cli
	# git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git $(HOME)/.solarized
	# cd $(HOME)/.solarized && ./install.sh && cd -
	# echo "eval `dircolors ~/.dir_colors/dircolors`" >> $(HOME)/.zshrc

.PHONY: terminal vim git shell
