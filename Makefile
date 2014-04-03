DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .gitignore_global .gitattributes_global
GO_ROOT = $(HOME)/go

help:
	make install # install dot files
	make git     # set git global config
	make go      # install go programming language. depend mercurial. need make install(depend .zshrc).
	make clean   # rm all

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
	source ~/.zshrc

git:
	git config --global color.ui true
	git config --global core.excludesfile ~/.gitignore_global
	git config --global core.attributesfile ~/.gitattributes_global

go:
ifeq "$(wildcard $(GO_ROOT))" ""
	cd ~ && hg clone -u release https://code.google.com/p/go
else
	cd ~/go && hg pull && hg update release
endif
	cd  ~/go/src && ./all.bash
	$(GO_ROOT)/bin/go get code.google.com/p/go.tools/cmd/godoc

clean:
	cd ~ && rm ${DOT_FILES}
