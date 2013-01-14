DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf

all:
	git pull
	git submodule init
	git submodule sync
	git submodule update
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), dotfile/$(f)) .
	mkdir ~/tmp

clean:
	cd ~ && rm ${DOT_FILES}
