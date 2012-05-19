DOT_FILES = .ctags .emacs .vimrc .zshrc

all:
	cd ~ && ln -sf $(foreach f, $(DOT_FILES), dotfile/$(f)) .

clean:
	cd ~ && rm ${DOT_FILES}

