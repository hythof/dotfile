DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global .fzf .agignore
DOTFILE_DIR = $(shell pwd)

help:
	@echo "make ubuntu for 18.04 mate"
	@echo "-- manual --"
	@echo "make install   # install dot files"
	@echo "make git       # set git global config"
	@echo "make clean     # rm all"
	@echo "make ubuntu    # install for desktop"

ubuntu:
	make ubuntu-init
	make ubuntu-font
	make install
	make git

install:
	git submodule init
	git submodule sync
	git submodule update
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), $(DOTFILE_DIR)/$(f)) .
	yes | .fzf/install
	mkdir -p ~/tmp

git:
	git config --global --replace-all color.ui true
	git config --global --replace-all core.excludesfile ~/.gitignore_global
	git config --global --replace-all core.attributesfile ~/.gitattributes_global

clean:
	cd ~ && rm ${DOT_FILES}
	sudo apt autoremove
	sudo apt autoclean

ubuntu-init:
	sudo apt update && sudo apt upgrade -y
	sudo apt purge -y nano firefox ubuntu-web-launchers "*libreoffice*" "printer-driver*" thunderbird "rhythmbox*"
	sudo apt install -y vim-nox zsh git tig silversearcher-ag ncdu atop iotop mercurial tmux libssl-dev ghc golang-go compizconfig-settings-manager nodejs compiz-plugins rbenv virtualenvwrapper docker.io
	xset r rate 220 80 # override the new limited keyboard repeat rate limit, 220 is rate, 80 is delay

ubuntu-font:
	sudo apt install -y fontforge
	mkdir -p ~/.fonts
	mkdir -p ~/tmp
	wget http://levien.com/type/myfonts/Inconsolata.otf -O ~/.fonts/Inconsolata.otf
	cd ~/tmp; wget "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip" -O migu-1m.zip
	cd ~/tmp; unzip migu-1m.zip
	cd ~/tmp; cp migu-1m-*/migu*.ttf ~/.fonts/
	cd ~/tmp; wget http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
	cd ~/tmp; wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf
	cd ~/tmp; wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf
	cd ~/tmp; sh ricty_generator.sh auto && cp *.ttf ~/.fonts
