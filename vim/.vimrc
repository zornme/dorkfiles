set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/moria'
Plugin 'Shougo/neocomplete.vim'
Plugin 'c9s/perlomni.vim'
Plugin 'matchit.zip'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-scripts/Align'
Plugin 'jpalardy/vim-slime'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'stephpy/vim-yaml'
Plugin 'simnalamburt/vim-mundo'
" Plugin 'vim-scripts/YankRing.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'chriskempson/base16-vim'

" Remap leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/.undo

nnoremap <leader>u :MundoToggle<CR>

let g:yankring_history_dir = '~/.vim/'
nnoremap <leader>p :YRShow<CR>

let g:airline_powerline_fonts = 1

" So vim-airline always shows
set laststatus=2

call vundle#end()
filetype plugin indent on

syntax on
colorscheme base16-tomorrow-night-eighties
" Tomorrow-Night-Eighties misses this for perl
hi perlStatement ctermfg=209 guifg=#f99157

set number
set numberwidth=4
set tabstop=4
set shiftwidth=4
set expandtab " father forgive me for i have sinned
set mouse=a
set nowrap

if has('gui_running')
  set guifont=Fira\ Code\ Regular:h12
  set guioptions-=T
  set columns=85
  set lines=42
  set colorcolumn=80
  set macligatures
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
map <CR> :ls<CR>

" F2 to trim trailing whitespace
" https://stackoverflow.com/questions/24148991/vim-is-inserting-q-when-i-hit-f2
map <Esc>OQ :%s/\s\+$//g
map <F2> :%s/\s\+$//g

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
  let g:ctrlp_user_command = 'ag %s -l -f --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Call attention to characters outside of the ASCII range
syntax match nonASCII "[^\x00-\x7F]"
highlight link nonASCII SpellBad

let g:neocomplete#enable_at_startup = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" Z - cd to recent / frequent directories
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
    let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
    echo path
    exec 'cd' fnameescape(path)
  endif
endfunction
