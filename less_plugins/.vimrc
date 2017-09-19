""" General settings
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

set path+=**                        " search files recursively
set wildmenu                         

set number
set relativenumber

inoremap jk <esc>                   
inoremap <esc> <nop>


""" vundle: install plugins support <8.0
set nocompatible                    " be iMproved, required
filetype off                        " required
set rtp+=~/.vim/bundle/Vundle.vim   " set the runtime path to include Vundle and initialize
call vundle#begin()

"" add more needed plugins here
" Plugin manager
Plugin 'VundleVim/Vundle.vim'

" Web development toolkit
Plugin 'mattn/emmet-vim'

" NERDtree
Plugin 'scrooloose/nerdtree'

" Sublime minimlist theme
Plugin 'rafi/awesome-vim-colorschemes'

" Laravel blade syntax highlight
Plugin 'jwalton512/vim-blade.git'

"polyglot -multiple programming languages support
Plugin 'sheerun/vim-polyglot'

"javascript-vim
Plugin 'pangloss/vim-javascript'


call vundle#end()                   " required
filetype plugin indent on           " required


""" Set color theme
syntax on
"color molokai
"set t_Co=256
set background=dark
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
syntax on
"colorscheme minimalist
"colorscheme dracula 
colorscheme molokai



""" let vim-blade.git recognize the customized directives
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }

""" Use ctags
command! MakeTags !ctags -R .

""" Take hyphen as part of a word
set iskeyword+=-

""" Key mapping
" set mapleader key
let mapleader=","

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" shortcut to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>


"""General auto-completion 
nnoremap <leader>" bi"<esc>ea"
nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{}}<esc>hi
inoremap {!! {!!!!}<esc>2hi
inoremap ( ()<esc>i

