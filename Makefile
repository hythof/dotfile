DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global
GO_ROOT = $(HOME)/go

help:
	@echo "make install # install dot files"
	@echo "make git     # set git global config"
	@echo "make go      # install go programming language. depend mercurial. need make install(depend .zshrc)."
	@echo "make clean   # rm all"

all:
	make install
	make git
	make go

install:
	git pull
	git submodule init
	git submodule sync
	git submodule update
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), dotfile/$(f)) .
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
