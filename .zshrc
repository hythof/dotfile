# 省略コマンド
alias -g L="| less"
alias -g G="| grep"
alias ls="ls --color"
alias l="ls -ltr"
alias ll="ls -alFh"
alias h="history"
alias s="screen -D -RR"

# git向け環境変数
export GIT_AUTHOR_NAME=`whoami`
export GIT_COMMITTER_NAME=`whoami`
export PATH=$PATH:~/bin:~/local/bin

# misc
export PATH=$HOME/local/bin:$HOME/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
export EDITOR=vi

# 色付きロンプト
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


HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=10000                        # メモリ内の履歴の数
SAVEHIST=10000                        # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
setopt share_history                  # 履歴の共有

bindkey -e                      # emacsライクなキー
autoload -U compinit; compinit  # 入力補助
setopt nolistbeep               # 補完時にビープ音を鳴らさない
setopt append_history           # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt auto_cd                  # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_list                # 補完候補が複数ある時に、一覧表示する
setopt auto_menu                # 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_param_keys          # カッコの対応などを自動的に補完する
setopt auto_param_slash         # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_resume              # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt NO_beep                  # ビープ音を鳴らさないようにする
setopt brace_ccl                # {a-c} を a b c に展開する機能を使えるようにする
setopt correct                  # コマンドのスペルチェックをする
setopt equals                   # =command を command のパス名に展開する
setopt extended_glob            # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt NO_flow_control          # Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt hist_ignore_dups         # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space        # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_verify              # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt NO_hup                   # シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt ignore_eof               # Ctrl+D では終了しないようになる（exit, logout などを使う）
setopt interactive_comments     # コマンドラインでも # 以降をコメントと見なす
setopt list_types               # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt long_list_jobs           # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt magic_equal_subst        # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt mark_dirs                # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt multios                  # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt numeric_glob_sort        # ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt print_eightbit           # 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt short_loops              # for, repeat, select, if, function などで簡略文法が使えるようになる
setopt prompt_subst             # 色を使う
setopt share_history            # シェルのプロセスごとに履歴を共有
setopt hist_no_store            # history (fc -l) コマンドをヒストリリストから取り除く。
unsetopt promptcr               # 文字列末尾に改行コードが無い場合でも表示する
setopt transient_rprompt        #コピペの時rpromptを非表示する
setopt autopushd                # cd -[tab] でpushd

#setopt auto_remove_slash       # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
#setopt bsd_echo                # 内部コマンドの echo を BSD 互換にする
#setopt chase_links             # シンボリックリンクは実体を追うようになる
#setopt clobber                 # 既存のファイルを上書きしないようにする
#setopt correct_all             # コマンドライン全てのスペルチェックをする
#setopt extended_history        # zsh の開始・終了時刻をヒストリファイルに書き込む
#setopt hash_cmds               # 各コマンドが実行されるときにパスをハッシュに入れる
#setopt single_line_zle         # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt xtrace                  # コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt mail_warning            # メールスプール $MAIL が読まれていたらワーニングを表示する
#setopt menu_complete           # 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
#setopt path_dirs               # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
#setopt print_exit_value        # 戻り値が 0 以外の場合終了コードを表示する
#setopt pushd_ignore_dups       # ディレクトリスタックに同じディレクトリを追加しないようになる
#setopt pushd_to_home           # pushd を引数なしで実行した場合 pushd $HOME と見なされる
#setopt rm_star_silent          # rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
#setopt rm_star_wait            # rm_star_silent の逆で、10 秒間反応しなくなり、頭を冷ます時間が与えられる

# 補完候補をカラーリング
#eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1

