set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'vim-scripts/moria'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'matchit.zip'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-scripts/Align'
Plugin 'jpalardy/vim-slime'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'stephpy/vim-yaml'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}


let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']

 let g:airline_powerline_fonts = 1

" So vim-airline always shows
set laststatus=2

call vundle#end()
filetype plugin indent on

syntax on
colorscheme Tomorrow-Night-Eighties

set number
set numberwidth=4
set tabstop=4
set shiftwidth=4
set expandtab " father forgive me for i have sinned
set mouse=a
set nowrap

if has('gui_running')
  set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
  set guioptions-=T
  set columns=85
  set lines=42
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

" ignore the node_modules directory throughout vim (but especially in ctrlp)
set wildignore+=*/node_modules/*

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

" Search upward for tags until reaching the home directory
set tags+=tags;$HOME

" Show blame for highlighted lines.
" http://robots.thoughtbot.com/post/159805638/integrating-vim-into-your-life
vmap <Leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" The Silver Searcher
" https://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
