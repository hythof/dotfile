" --( customize )-----------------------------------------
nnoremap J :cn <CR>
nnoremap K :cN <CR>
"nnoremap <space>r :<C-u>source $MYVIMRC <CR>
nnoremap <space>e :e %:h/
nnoremap gl :!git log --graph --decorate --oneline % <CR>
nnoremap gb :silent execute ":!cd %:h; git blame --date=short -L" . line('w0') . " %:p" \| redraw!
au BufRead,BufNewFile *.spa set filetype=spa
au BufRead,BufNewFile *.vl set filetype=vl

" ---( generic )--------------------------------------
"新しい行のインデントを現在行と同じにする
set autoindent

"半角文字対応
set ambiwidth=double

"Vi互換をオフ
set nocompatible

"自動改行をOff
set nowrap
set formatoptions=q    

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

" ウィンドウを開く向きを指定
set splitright
"set splitbelow

" プレビューウィンドウの高さ指定
set previewheight=20

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

" .swpファイルの保存先
set directory=~/tmp

" ~ファイルの保存先
set backupdir=~/tmp

" カーソル行を目立たせる
:set cursorline
":set cursorcolumn

" ステータス行
set laststatus=2
set statusline=%<%F\ %m%r%h%w
set statusline+=%=
set statusline+=[%c:%l]
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}
set statusline+=%{'['.&fileformat.']'}

" vimpath
let $PATH = $PATH . ':~/.vim/bin' 

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END


" --( ctags )-----------------------------------------
set tags=./tags;~ " カレントディレクトリからルートへ向けて再起検索、~で検索打ち止め
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


" ---( vundle )--------------------------------------
" git clone http://github.com/gmarik/vundle.git ~/.vim/vundle.git
set nocompatible " be iMproved, required
filetype off     " required
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" --
Bundle "klen/python-mode"
let g:pymode_doc_key = 'H'
let g:pymode_folding = 0
let g:pymode_virtualenv = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_run_key = '<leader>r'
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0

" --
Bundle 'Shougo/unite.vim'
nnoremap <space><space> :<C-u>Unite -no-split source <CR> :<C-u>Unite 
nnoremap <space>b :<C-u>Unite -auto-resize buffer<CR>
nnoremap <space>f :<C-u>Unite -auto-resize file_rec/async<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :bd<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:bd<CR>

" --
Bundle 'Shougo/vimproc.vim'

" --
Bundle 'tsukkee/unite-tag'

" --
Bundle 'Shougo/unite-outline'
nnoremap <space>o :<C-u>Unite -auto-resize -auto-highlight outline<CR>

" --
Bundle 'kchmck/vim-coffee-script'

" --
Bundle 'fatih/vim-go'
let g:go_fmt_fail_silently = 0
let g:go_fmt_autosave = 1
au FileType go nmap <space>i <Plug>(go-info)
au FileType go nmap <space>d <Plug>(go-doc-vertical)
au FileType go nmap <space>r <Plug>(go-run)
au FileType go nmap <space>b <Plug>(go-build)
au FileType go nmap <space>t <Plug>(go-test)
au FileType go nmap <space>c <Plug>(go-coverage)
au FileType go nmap <space>t <Plug>(go-def-tab)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" --
Bundle "vim-erlang/vim-erlang-tags"
:set runtimepath^=~/.vim/bundle/vim-erlang-tags


" --
filetype plugin indent on  " required
