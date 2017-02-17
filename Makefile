DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global
GO_ROOT = $(HOME)/go
GO14_ROOT = $(HOME)/go1.4
DOTFILE_DIR = $(shell pwd)
GNOME_TERMINAL_COLOR_DIR = $(HOME)/tmp/gnome-terminal-colors-solarized

help:
	@echo "make all       # make install, git, go, haskell"
	@echo "make install   # install dot files"
	@echo "make git       # set git global config"
	@echo "make haskell   # install haskell"
	@echo "make clean     # rm all"
	@echo "make html5tidy # install html5tidy"
	@echo "-- ubuntu --"
	@echo "make ubuntu-init"
	@echo "make ubuntu-font"
	@echo "-- move other machine --"
	@echo "make snap"

all:
	make install
	make git

install:
	git pull
	git submodule init
	git submodule sync
	git submodule update
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), $(DOTFILE_DIR)/$(f)) .
	mkdir -p ~/tmp

git:
	git config --global --replace-all color.ui true
	git config --global --replace-all core.excludesfile ~/.gitignore_global
	git config --global --replace-all core.attributesfile ~/.gitattributes_global
	git config --global pull.rebase true

haskell:
	sudo aptitude install haskell-stack

clean:
	cd ~ && rm ${DOT_FILES}
	sudo apt-get autoremove
	sudo aptitude autoclean

html5tidy:
	sudo aptitude install cmake
	bash bin/install_html5tidy.sh

ubuntu-init:
	sudo apt-get install aptitude
	sudo aptitude update && sudo aptitude upgrade
	sudo aptitude purge nano unity-webapps-common firefox
	sudo apt-get remove --purge "libreoffice*"
	sudo aptitude install vim-nox-py2 zsh git mercurial chromium-browser tmux libssl-dev ghc golang-go
	xset r rate 220 80 # override the new limited keyboard repeat rate limit, 220 is rate, 80 is delay

ubuntu-font:
	sudo aptitude install fontforge gnome-tweak-tool
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
	gnome-tweak-tool &

snap:
	cd ~; tar -zcvf /tmp/home.tar.gz .ssh .gnupg git
