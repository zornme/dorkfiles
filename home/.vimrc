set nocompatible
filetype off
" use pathogen to easily handle plugins in .vim/bundle
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax on
colorscheme desert
set background=dark
set number
set numberwidth=4
set tabstop=4
set shiftwidth=4
set expandtab " father forgive me for i have sinned
set mouse=a
set nowrap

if has('gui_running')
  colorscheme moria
  set guifont=Droid\ Sans\ Mono:h12
  set guioptions-=T
  set columns=85
  set lines=42
  highlight ColorColumn guibg=#2f2f2f
  set colorcolumn=80
endif

" shut the fuck up
set visualbell
set noerrorbells

" intuitive backspacing in insert mode
set backspace=indent,eol,start
" more intuitive moving up/down over wrapped lines
nnoremap j gj
nnoremap k gk

" keep a longer command/search history
set history=1000

" hide rather than destroy buffers
set hidden

" set current working directory to that of the current buffer
if has("autochdir")
  set autochdir
endif

" show last command and highlight size
set ruler
set showcmd

" blink matching parentheses/brackets etc
set showmatch
set matchtime=3

" don't highlight matching parenthesis
let g:loaded_matchparen=1

" make ctrlp follow symlinks
let g:ctrlp_follow_symlinks=1
" don't let ctrlp change its working directory
let g:ctrlp_working_path_mode=0

" show tabs and trailing
if has('multi_byte')
  scriptencoding utf-8
  set listchars=tab:▸\ ,trail:·
  set list
endif

" enter key to list buffers
map  :ls

" F2 to trim trailing whitespace
map <F2> :%s/\s\+$//g

" jj as <Esc> in insert mode
imap jj <Esc>

"" keep swapfiles from cluttering up pwd
set dir=~/.vim/.swap//,/var/tmp//,/tmp//,.

" autoload changed files
set autoread

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz
