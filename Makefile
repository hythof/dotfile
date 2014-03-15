DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .cvsrc .gitignore_global .gitattributes_global

all:
	make install
	make git

install:
	git pull
	git submodule init
	git submodule sync
	git submodule update
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), dotfile/$(f)) .
	mkdir -p ~/tmp

git:
	git config --global color.ui true
	git config --global core.excludesfile ~/.gitignore_global
	git config --global core.attributesfile ~/.gitattributes_global

clean:
	cd ~ && rm ${DOT_FILES}
