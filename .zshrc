# �ȗ��R�}���h
alias -g L="| less"
alias -g G="| grep"
alias ls="ls --color"
alias l="ls -ltr"
alias ll="ls -alFh"
alias h="history"
alias s="screen -D -RR"

# git�������ϐ�
export GIT_AUTHOR_NAME=`whoami`
export GIT_COMMITTER_NAME=`whoami`
export PATH=$PATH:~/bin:~/local/bin

# misc
export PATH=$HOME/local/bin:$HOME/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
export EDITOR=vi

# �F�t�������v�g
autoload colors
colors
case "$TERM" in
xterm*|kterm*|rxvt*|screen)
    PROMPT="%{${fg[green]}%}%m@%n%%%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
    RPROMPT="[%{${fg[green]}%}%~%{${reset_color}%}]"

    ;;
*)
    PROMPT='%m:%c%# '
    ;;
esac
case "${TERM}" in screen)
    preexec() {
        echo -ne "\ek${1%% *}\e\\"
    }
esac


HISTFILE=$HOME/.zsh-history           # �������t�@�C���ɕۑ�����
HISTSIZE=10000                        # ���������̗����̐�
SAVEHIST=10000                        # �ۑ�����闚���̐�
setopt extended_history               # �����t�@�C���Ɏ������L�^
setopt share_history                  # �����̋��L

bindkey -e                      # emacs���C�N�ȃL�[
autoload -U compinit; compinit  # ���͕⏕
setopt nolistbeep               # �⊮���Ƀr�[�v����炳�Ȃ�
setopt append_history           # ������ zsh �𓯎��Ɏg�����Ȃ� history �t�@�C���ɏ㏑�������ǉ�����
setopt auto_cd                  # �w�肵���R�}���h�����Ȃ��A�f�B���N�g�����ƈ�v�����ꍇ cd ����
setopt auto_list                # �⊮��₪�������鎞�ɁA�ꗗ�\������
setopt auto_menu                # �⊮�L�[�iTab, Ctrl+I) ��A�ł��邾���ŏ��ɕ⊮���������ŕ⊮����
setopt auto_param_keys          # �J�b�R�̑Ή��Ȃǂ������I�ɕ⊮����
setopt auto_param_slash         # �f�B���N�g�����̕⊮�Ŗ����� / �������I�ɕt�����A���̕⊮�ɔ�����
setopt auto_resume              # �T�X�y���h���̃v���Z�X�Ɠ����R�}���h�������s�����ꍇ�̓��W���[������
setopt NO_beep                  # �r�[�v����炳�Ȃ��悤�ɂ���
setopt brace_ccl                # {a-c} �� a b c �ɓW�J����@�\���g����悤�ɂ���
setopt correct                  # �R�}���h�̃X�y���`�F�b�N������
setopt equals                   # =command �� command �̃p�X���ɓW�J����
setopt extended_glob            # �t�@�C������ #, ~, ^ �� 3 �����𐳋K�\���Ƃ��Ĉ���
setopt NO_flow_control          # Ctrl+S/Ctrl+Q �ɂ��t���[������g��Ȃ��悤�ɂ���
setopt hist_ignore_dups         # ���O�Ɠ����R�}���h���C���̓q�X�g���ɒǉ����Ȃ�
setopt hist_ignore_space        # �R�}���h���C���̐擪���X�y�[�X�Ŏn�܂�ꍇ�q�X�g���ɒǉ����Ȃ�
setopt hist_verify              # �q�X�g�����Ăяo���Ă�����s����ԂɈ�U�ҏW�ł����ԂɂȂ�
setopt NO_hup                   # �V�F�����I�����Ă����W���u�� HUP �V�O�i���𑗂�Ȃ��悤�ɂ���
setopt ignore_eof               # Ctrl+D �ł͏I�����Ȃ��悤�ɂȂ�iexit, logout �Ȃǂ��g���j
setopt interactive_comments     # �R�}���h���C���ł� # �ȍ~���R�����g�ƌ��Ȃ�
setopt list_types               # auto_list �̕⊮���ꗗ�ŁAls -F �̂悤�Ƀt�@�C���̎�ʂ��}�[�N�\��
setopt long_list_jobs           # �����R�}���h jobs �̏o�͂��f�t�H���g�� jobs -l �ɂ���
setopt magic_equal_subst        # �R�}���h���C���̈����� --prefix=/usr �Ȃǂ� = �ȍ~�ł��⊮�ł���
setopt mark_dirs                # �t�@�C�����̓W�J�Ńf�B���N�g���Ƀ}�b�`�����ꍇ������ / ��t������
setopt multios                  # �����̃��_�C���N�g��p�C�v�ȂǁA�K�v�ɉ����� tee �� cat �̋@�\���g����
setopt numeric_glob_sort        # �t�@�C�����̓W�J�ŁA�������ł͂Ȃ����l�I�Ƀ\�[�g�����悤�ɂȂ�
setopt print_eightbit           # 8 �r�b�g�ڂ�ʂ��悤�ɂȂ�A���{��̃t�@�C�����Ȃǂ������悤�ɂȂ�
setopt short_loops              # for, repeat, select, if, function �ȂǂŊȗ����@���g����悤�ɂȂ�
setopt prompt_subst             # �F���g��
setopt share_history            # �V�F���̃v���Z�X���Ƃɗ��������L
setopt hist_no_store            # history (fc -l) �R�}���h���q�X�g�����X�g�����菜���B
unsetopt promptcr               # �����񖖔��ɉ��s�R�[�h�������ꍇ�ł��\������
setopt transient_rprompt        #�R�s�y�̎�rprompt���\������
setopt autopushd                # cd -[tab] ��pushd

#setopt auto_remove_slash       # �Ōオ�f�B���N�g�����ŏI����Ă���ꍇ������ / �������I�Ɏ�菜��
#setopt bsd_echo                # �����R�}���h�� echo �� BSD �݊��ɂ���
#setopt chase_links             # �V���{���b�N�����N�͎��̂�ǂ��悤�ɂȂ�
#setopt clobber                 # �����̃t�@�C�����㏑�����Ȃ��悤�ɂ���
#setopt correct_all             # �R�}���h���C���S�ẴX�y���`�F�b�N������
#setopt extended_history        # zsh �̊J�n�E�I���������q�X�g���t�@�C���ɏ�������
#setopt hash_cmds               # �e�R�}���h�����s�����Ƃ��Ƀp�X���n�b�V���ɓ����
#setopt single_line_zle         # �f�t�H���g�̕����s�R�}���h���C���ҏW�ł͂Ȃ��A�P�s�ҏW���[�h�ɂȂ�
#setopt xtrace                  # �R�}���h���C�����ǂ̂悤�ɓW�J������s���ꂽ����\������悤�ɂȂ�
#setopt mail_warning            # ���[���X�v�[�� $MAIL ���ǂ܂�Ă����烏�[�j���O��\������
#setopt menu_complete           # �⊮��₪�������鎞�A�ꗗ�\�� (auto_list) �����A�����ɍŏ��̌���⊮����
#setopt path_dirs               # �R�}���h���� / ���܂܂�Ă���Ƃ� PATH ���̃T�u�f�B���N�g����T��
#setopt print_exit_value        # �߂�l�� 0 �ȊO�̏ꍇ�I���R�[�h��\������
#setopt pushd_ignore_dups       # �f�B���N�g���X�^�b�N�ɓ����f�B���N�g����ǉ����Ȃ��悤�ɂȂ�
#setopt pushd_to_home           # pushd �������Ȃ��Ŏ��s�����ꍇ pushd $HOME �ƌ��Ȃ����
#setopt rm_star_silent          # rm * �Ȃǂ̍ہA�{���ɑS�Ẵt�@�C���������ėǂ����̊m�F���Ȃ��悤�ɂȂ�
#setopt rm_star_wait            # rm_star_silent �̋t�ŁA10 �b�Ԕ������Ȃ��Ȃ�A�����܂����Ԃ��^������

# �⊮�����J���[�����O
#eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1

