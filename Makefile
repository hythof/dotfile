DOT_FILES = .ctags .emacs .vim .vimrc .zshrc .tmux.conf .gitignore_global

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
	git config --global --add core.excludesfile "$HOME/.gitignore_global"
	git config alias.diff-ex "diff --color-words"

clean:
	cd ~ && rm ${DOT_FILES}
