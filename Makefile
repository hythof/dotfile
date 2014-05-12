DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global
GO_ROOT = $(HOME)/go
DOTFILE_DIR = $(shell pwd)

help:
	@echo "make all     # make install, git, go"
	@echo "make install # install dot files"
	@echo "make git     # set git global config"
	@echo "make go      # install go programming language. depend mercurial. need make install(depend .zshrc)."
	@echo "make clean   # rm all"
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

go:
ifeq "$(wildcard $(GO_ROOT))" ""
	cd ~ && hg clone -u release https://code.google.com/p/go
else
	cd ~/go && hg pull && hg update release
endif
	cd  ~/go/src && ./all.bash
	zsh -c "$(GO_ROOT)/bin/go get code.google.com/p/go.tools/cmd/godoc"

clean:
	cd ~ && rm ${DOT_FILES}


ubuntu-init:
	sudo apt-get install aptitude
	sudo aptitude update && sudo aptitude upgrade
	sudo aptitude purge nano
	sudo aptitude install vim-nox zsh git mercurial chromium-browser
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
	mkdir -p ~/tmp
	(cd ~/tmp && git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git && cd gnome-terminal-colors-solarized && ./install.sh)
