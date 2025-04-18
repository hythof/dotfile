" --( customize )-----------------------------------------
nnoremap s <Nop>
nnoremap sb :Buffers <cr>
nnoremap ss :e # <cr>
nnoremap se :e %:h/
nnoremap sv :e ~/.vimrc <cr>
nnoremap sf :Files <cr>
nnoremap sa :Ag! <cr>
nnoremap sl :BLines <cr>
nnoremap sr :source ~/.vimrc <cr>:e!<cr>
nnoremap st :Tags <cr>
"nnoremap sg :%s/></>\r</g <cr>gg=G
nnoremap sh :Helptags <cr>
nnoremap sgm :!tig main % <cr><cr>
nnoremap sgl :!tig log % <cr><cr>
nnoremap sgb :silent! !tig blame -f +<C-r>=line('.')<cr> %<cr>:redraw!<cr>
nnoremap sgr :!tig refs <cr><cr>
nnoremap sgs :!tig status <cr><cr>
nnoremap sp :setlocal spell spelllang=en <cr>
nnoremap sn :setlocal nospell <cr>

" --( customize )-----------------------------------------
au BufRead,BufNewFile *.moa set filetype=moa
exe 'set runtimepath+=~/git/moa/misc/vim/'
au! BufRead,BufNewFile *.moa setlocal filetype=moa fileencoding=utf-8 fileformat=unix

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
"タブはスペースx2
set tabstop=2
set softtabstop=2
"シフト移動幅
set shiftwidth=2
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

" ウィンドウを開く向きを指定
set splitright
"set splitbelow

" プレビューウィンドウの高さ指定
set previewheight=20

" Disable netrw
let g:netrw_dirhistmax=0

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

" カーソル行を目立たせる(重い)
":set cursorline
":set cursorcolumn

" turn off beep sound
set belloff=all

" ステータス行
highlight StatusLine ctermbg=gray ctermfg=black
set laststatus=2
set statusline=%<%F\ %m%r%h%w
set statusline+=%=
set statusline+=[%c:%l]
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}
set statusline+=%{'['.&fileformat.']'}

" vimpath
let $PATH = $PATH . ':~/.vim/bin'

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
"augroup BinaryXXD
"  autocmd!
"  autocmd BufReadPre  *.bin let &binary =1
"  autocmd BufReadPost * if &binary | silent %!xxd -g 1
"  autocmd BufReadPost * set ft=xxd | endif
"  autocmd BufWritePre * if &binary | "%!xxd -r" | endif
"  autocmd BufWritePost * if &binary | silent %!xxd -g 1
"  autocmd BufWritePost * set nomod | endif
"augroup END

" vimgrepを使いやすく
"au QuickfixCmdPost vimgrep cw
"nnoremap <expr> <Space>g ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')

" sync clipboard
set clipboard=
vnoremap <leader>y "+y

" --( changelog )-----------------------------------------
let g:changelog_username = "Hiroshi"

" --( ctags )-----------------------------------------
" カレントディレクトリからルートへ向けて再起検索、~で検索打ち止め
set tags=./tags;~

" 複数候補時に選択肢を表示
nmap <C-]> g<C-]>

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


" ---( Plugins )--------------------------------------
" -- off
set nocompatible " be iMproved, required
filetype off     " required

" -- plug begin
call plug#begin('~/.vim/plugged')

" -- haskell
Plug 'kana/vim-filetype-haskell'
Plug 'Twinside/vim-hoogle'
"Plug 'nbouscal/vim-stylish-haskell'

" -- python
Plug 'klen/python-mode'
let g:pymode_doc_key = 'H'
let g:pymode_folding = 0
let g:pymode_virtualenv = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_run_key = '<leader>r'
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0

" -- show trailing whitespace
Plug 'bronson/vim-trailing-whitespace'
let g:extra_whitespace_ignored_filetypes = ['markdown']

" -- go
Plug 'fatih/vim-go'
let g:go_fmt_fail_silently = 0
let g:go_fmt_autosave = 1
au FileType go nmap <C-i> <Plug>(go-info)
au FileType go nmap <C-d> <Plug>(go-doc-vertical)
"au FileType go nmap <C-r> <Plug>(go-run)
"au FileType go nmap <C-b> <Plug>(go-build)
"au FileType go nmap <C-t> <Plug>(go-test)
"au FileType go nmap <C-c> <Plug>(go-coverage)
"au FileType go nmap <C-t> <Plug>(go-def-tab)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" -- Erlang
Plug 'vim-erlang/vim-erlang-tags'
:set runtimepath^=~/.vim/bundle/vim-erlang-tags/

" -- PHP
autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4

" -- Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

" -- Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'janko-m/vim-test'

" -- show changing on the staging
Plug 'airblade/vim-gitgutter'

" -- vue
Plug 'posva/vim-vue'
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" -- emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
\  'html': {
\    'default_attributes': {
\      'textarea': {},
\    },
\    'snippets': {
\      'html': "<!document html>\n"
\              ."<html>\n"
\              ."<head>\n"
\              ."<meta charset=utf-8>\n"
\              ."<title></title>\n"
\              ."<meta name=viewport content=width=device-width,initial-scale=1.0>\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\      'textarea': "<textarea>${child}|</textarea>"
\    },
\  },
\}
autocmd FileType html,css,vue EmmetInstall

" -- Type Script
Plug 'leafgarland/typescript-vim'

" -- fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf
let g:fzf_layout = { 'up': '~40%' }

" -- syntax hilight for many programming languages
Plug 'sheerun/vim-polyglot'

" -- extend registers
Plug 'junegunn/vim-peekaboo'

" -- plug end
call plug#end()

" -- on
filetype on  " required
filetype plugin indent on  " required

" 環境依存
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
