DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global
GO_ROOT = $(HOME)/go
GO14_ROOT = $(HOME)/go1.4
DOTFILE_DIR = $(shell pwd)
GNOME_TERMINAL_COLOR_DIR = $(HOME)/tmp/gnome-terminal-colors-solarized

help:
	@echo "make all       # make install, git, go"
	@echo "make install   # install dot files"
	@echo "make git       # set git global config"
	@echo "make go        # install go programming language. depend mercurial. need make install(depend .zshrc)."
	@echo "make clean     # rm all"
	@echo "make html5tidy # install html5tidy"
	@echo "-- platform --"
	@echo "make ubuntu-init"
	@echo "make ubuntu-font"
	@echo "make ubuntu-terminal-theme"

all:
	make install
	make git
	make go

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

go:
ifeq "$(wildcard $(GO_ROOT))" ""
	cd ~ && git clone https://github.com/golang/go.git
else
	cd $(GO_ROOT) && git pull
endif
ifeq "$(wildcard $(GO14_ROOT)/bin/go)" ""
	cd ~ && cp -pr $(GO_ROOT) $(GO14_ROOT)
	cd $(GO14_ROOT)/src && git checkout -b release-branch.go1.4 origin/release-branch.go1.4 && ./all.bash
endif
	cd  $(GO_ROOT)/src && ./all.bash
	zsh -c "$(GO_ROOT)/bin/go get golang.org/x/tools/cmd/godoc"
	go get golang.org/x/tools/cmd/goimports

clean:
	cd ~ && rm ${DOT_FILES}

html5tidy:
	sudo aptitude install cmake
	bash bin/install_html5tidy.sh

ubuntu-init:
	sudo apt-get install aptitude
	sudo aptitude update && sudo aptitude upgrade
	sudo aptitude purge nano unity-webapps-common firefox
	sudo apt-get remove --purge "libreoffice*"
	sudo aptitude install vim-nox zsh git mercurial chromium-browser tmux
	xset r rate 220 80 # override the new limited keyboard repeat rate limit, 220 is rate, 80 is delay

ubuntu-font:
	sudo aptitude install fontforge gnome-tweak-tool
	mkdir -p ~/.fonts
	mkdir -p ~/tmp
	wget http://levien.com/type/myfonts/Inconsolata.otf -O ~/.fonts/Inconsolata.otf
	cd ~/tmp; wget "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip" -O migu-1m.zip
	cd ~/tmp; unzip migu-1m.zip
	cd ~/tmp; cp migu-1m-*/migu*.ttf ~/.fonts/
	cd ~/tmp; git clone git://github.com/yascentur/Ricty.git
	(cd ~/tmp/Ricty && sh ricty_generator.sh auto && cp *.ttf ~/.fonts)
	cd ~/.fonts; rm Inconsolata.otf migu-1m*
	gnome-tweak-tool &

ubuntu-terminal-theme:
ifeq "$(wildcard $(GNOME_TERMINAL_COLOR_DIR))" ""
	mkdir -p ~/tmp
	(cd ~/tmp && git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git)
else
	(cd ~/tmp/gnome-terminal-colors-solarized && git pull)
endif
	(cd ~/tmp/gnome-terminal-colors-solarized && ./install.sh)
