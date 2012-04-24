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
set tabstop=2
set shiftwidth=2
set expandtab " father forgive me for i have sinned
set mouse=a
set nowrap

if has('gui_running')
  colorscheme Tomorrow-Night-Eighties
  set guifont=Droid\ Sans\ Mono:h12
  set guioptions-=T
  set columns=85
  set lines=42
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

" show tabs and trailing
if has('multi_byte')
  scriptencoding utf-8
  set listchars=tab:▸\ ,trail:·
  set list
endif

" enter key to list buffers
map 

" F2 to trim trailing whitespace
map <F2> :%s/\s\+$//g

" jj as <Esc> in insert mode
imap jj <Esc>