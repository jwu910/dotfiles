set nocompatible              " be iMproved, required
set encoding=utf-8
" filetype off                  " required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" ===== Add custom plugins below this line =====

" Syntax Files
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-js'

" Custom plugins
" Plug 'Valloric/YouCompleteMe' " Autocomplete
Plug 'Yggdroot/indentline'
Plug 'airblade/vim-gitgutter' " GitGutter for Vim
Plug 'alvan/vim-closetag'
Plug 'editorconfig/editorconfig-vim' " Editor Config
Plug 'henrik/vim-indexed-search'
Plug 'prettier/vim-prettier'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree' " Tree view file browser
Plug 'tpope/vim-commentary' " Comment out lines with 'gcc'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline' " Status bar for vim
Plug 'psf/black', { 'branch': 'stable' }
" Plug 'w0rp/ale', { 'tag': 'v1.9.1' }

" Snippets
Plug 'SirVer/ultisnips'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'honza/vim-snippets'


" Install fzf plugin
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Theme Installs
Plug 'mhartington/oceanic-next'

" ===== Add custom plugins above this line =====

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on

syntax on

" ===  Themes  ===
if (has("termguicolors"))
	set termguicolors
endif

colorscheme OceanicNext

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:vim_vue_plugin_use_scss= 1
let g:vim_vue_plugin_highlight_vue_keyword= 1


" Ale
highlight ALEError ctermbg=Blue

let g:ale_fixers = {
			\    'javascript': ['eslint', 'prettier'],
			\    'typescript': ['prettier'],
			\    'vue': ['eslint'],
			\    'scss': ['prettier'],
			\    'html': ['prettier']
			\}
let g:ale_fix_on_save = 1


" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.js,*.jsp,*.jsx,*.ts,*.tsx,*.xml,*.vue"
let g:mta_filetypes = {
			\ 'html' : 1,
			\ 'xhtml': 1,
			\ 'xml' : 1,
			\ 'js' : 1,
			\ 'jsx' : 1,
			\ 'jsp': 1,
			\ 'ts': 1,
			\ 'tsx': 1,
			\ 'vue': 1
			\}

" fzf
let g:fzf_layout = { 'down': '~20%' }
map <C-P> :FZF<CR>

" Indent Line
let g:indentLine_char = '•'
let g:indentLine_concealcursor = "c"

" NerdTree
let NERDTreeShowHidden = 1
map <C-\> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Prettier
let g:prettier#autoformat = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

" Vim Sort Motion
let g:sort_motion_flags = "ui"

"""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap j jzz
nnoremap k kzz


set background=dark
set hlsearch
set mouse=a
set number
set lazyredraw
set relativenumber
set splitbelow
set splitright
set ttymouse=sgr
set cursorline
set nofixendofline
set backspace=indent,eol,start

" Use tabs instead of spaces
set shiftwidth=4
set tabstop=4
set sts=4
set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Autorun configs
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoreload file on change
set autoread
au WinEnter * checktime

" Remove trailing whitespaces
au BufWritePre * :%s/\s\+$//e

" Set syntax to file types files
au BufNewFile,BufReadPost *.md set filetype=markdown
au BufRead,BufNewFile *.*-alias set filetype=sh
au BufRead,BufNewFile *.*-environment set filetype=sh
au BufRead,BufNewFile *.ftl set filetype=html
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
au BufReadPost *.snap set syntax=jsx

" Prettier auto-format before saving async
au BufWritePre *.scss,*.css,*.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.graphql,*.md,*.vue PrettierAsync

set clipboard=unnamedplus
