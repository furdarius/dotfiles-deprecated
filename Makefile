CWD=$(shell pwd)

all: terminal vim git shell

terminal:
	# http://www.linuxandubuntu.com/home/terminator-a-linux-terminal-emulator-with-multiple-terminals-in-one-window
	curl -fLo $(HOME)/terminator-src.tar.gz https://launchpad.net/terminator/gtk3/1.91/+download/terminator-1.91.tar.gz \
		&& tar -xzf $(HOME)/terminator-src.tar.gz -C $(HOME) \
		&& rm -rf $(HOME)/terminator-src.tar.gz \
		&& cd $(HOME)/terminator-* \
		&& sudo ./setup.py install \
		&& cd -
	ln -s $(CWD)/terminator $(HOME)/.config/terminator

vim:
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.vim
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.config/terminator
	ln -s $(CWD)/.vimrc $(HOME)/.vimrc
	mkdir $(HOME)/.vim
	ln -s $(HOME)/.vim $(HOME)/.config/nvim
	ln -s $(HOME)/.vimrc $(HOME)/.vim/init.vim
	@curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git:
	rm -rf $(HOME)/.gitconfig
	ln -s $(CWD)/.gitconfig $(HOME)/.gitconfig

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
