" ---( generic )--------------------------------------
"新しい行のインデントを現在行と同じにする
set autoindent

"Vi互換をオフ
set nocompatible

"タブの代わりに空白文字を挿入する
set expandtab
"タブはスペースx4
set tabstop=4
"シフト移動幅
set shiftwidth=4
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"変更中のファイルでも、保存しないで他のファイルを表示
set hidden

"インクリメンタルサーチを行う
"set incsearch

"タブ文字、行末など不可視文字を表示する
"set list

"listで表示される文字のフォーマットを指定する
set listchars=eol:$,tab:>\ ,extends:<

"行番号を表示する
set number

"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch

"検索時に大文字を含んでいたら大/小を区別
set smartcase

"新しい行を作ったときに高度な自動インデントを行う
set smartindent

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"検索をファイルの先頭へループしない
set nowrapscan

"カラー表示
syntax on

"検索結果をハイライト
set hlsearch

"ウィンドウを最大化して起動
au GUIEnter * simalt ~x

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 日本語の設定
set termencoding=utf-8
"set encoding=japan
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp

" 改行コードの優先順位
set fileformats=unix,dos,mac

" vimproc
let g:vimproc_dll_path = $HOME."/.vim/autoload/proc.so"

" コピペでさらにインデントしない
set paste

" .swpファイルの保存先
set directory=~/tmp

" ~ファイルの保存先
set backupdir=~/tmp

" --( ctags )-----------------------------------------
set tags=TAGS;~ " カレントディレクトリからルートへ向けて再起検索、~で検索打ち止め
nmap <C-]> g<C-]> " 複数候補時に選択肢を表示


" ---( Gnu PG )----------------------------------------
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre *.gpg set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre *.gpg set bin
autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost *.gpg set nobin
autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost *.gpg u 


" ---( vim bundle )--------------------------------------
" bundle
call pathogen#infect()

" python-mode
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

