set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ===== Add custom plugins below this line =====
" GitGutter for Vim
Plugin 'airblade/vim-gitgutter'

" Syntax Files
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Editor Config
Plugin 'editorconfig/editorconfig-vim'

" Highlight Whitespace
Plugin 'ntpeters/vim-better-whitespace'

" CtrlP search
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'henrik/vim-indexed-search'

" Tree view file browser
Plugin 'scrooloose/nerdtree'

Plugin 'vim-airline/vim-airline'

" Git in vim
Plugin 'jreybert/vimagit'

Plugin 'prettier/vim-prettier'

" Commentary
Plugin 'tpope/commentary'

" Syntastic -- not sure if installed correctly.
Plugin 'syntastic'
" Themes
Plugin 'flazz/vim-colorschemes'

" ===== Add custom plugins above this line =====

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ===  Themes  ===
colorscheme zenburn

" Nerdtree settings
map <C-\> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Ctrl P Settings
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.?(git|hg|svn|node_modules|classes|build|dist)$',
  \ }

" JSX Syntax Highlighting
let g:jsx_ext_required = 0

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


nnoremap j jzz
nnoremap k kzz

syntax on

set background=dark
set shiftwidth=4
set tabstop=4
set expandtab
set hlsearch
set mouse=a
set number
set relativenumber
set splitbelow
set splitright
set sts=2
set ttymouse=sgr
set cursorline
set nofixendofline

" Autorun configs
autocmd BufWritePre * %s/\s\+$//e
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set clipboard=unnamed
