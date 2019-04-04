" Initial settings {{{
set nocompatible
set encoding=utf-8
set wildignore=vendor/**,node_modules/**
" }}}
"
" Custom Functions {{{  
" endfunction
" }}}

" Plugin Manager - Vim-Plug  {{{  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install the plugin manager itself 
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
""" Tmux pane-navigation 
Plug 'christoomey/vim-tmux-navigator'       

""" Table mode
Plug 'dhruvasagar/vim-table-mode'

""" Auto generating React snippets 
Plug 'epilande/vim-react-snippets'          

""" Code snippets for multiple languages.
Plug 'honza/vim-snippets'

""" Debugger frontend
Plug 'idanarye/vim-vebugger', {
   \ 'branch': 'develop' ,
   \ }

"""" Hightline and indentation fro UraphQL 
"" Plug 'jparise/vim-graphql'

""" Fuzzy file finder and Multi-entry selection, for LanguagClient neovim
Plug 'junegunn/fzf', {
   \ 'dir': '~/.fzf', 
   \ 'do': './install --all'
   \ }
Plug 'junegunn/fzf.vim'

" Auto generating HTML/XML tags 
Plug 'mattn/emmet-vim'

""" A plugin to select date with cursor 
Plug 'mattn/calendar-vim'

""" Manage searching tools for vim
Plug 'mileszs/ack.vim'

""" Vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
""" Asyncomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'           " vim-lsp source
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'     " ultisnips source
Plug 'prabirshrestha/asyncomplete-file.vim'          " file source 
Plug 'prabirshrestha/asyncomplete-buffer.vim'        " buffer source
""" Searching files asynchornously
Plug 'rking/ag.vim'                         

""" Hightline the same word under the cursor
Plug 'RRethy/vim-illuminate'

""" Collection of syntax and indentation
Plug 'sheerun/vim-polyglot'

""" Browse/manage files in tree view 
Plug 'scrooloose/nerdtree'

""" General sinippets management
Plug 'SirVer/ultisnips'

""" Comment/uncomment code  
Plug 'tpope/vim-commentary'

""" Change surrounding, e.g: quotation. 
Plug 'tpope/vim-surround'

""" Vim git integration
Plug 'tpope/vim-fugitive'

""" Color theme  
Plug 'tomasr/molokai'

""" Show the matching tag 
Plug 'valloric/matchtagalways'

""" Kotlin
Plug 'udalov/kotlin-vim'

""" Add numbers incresingly
Plug 'vim-scripts/VisIncr'

""" personal wiki management
Plug 'vimwiki/vimwiki'

""" Alway onpen NERDtree at start up
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}

"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
"" UltiSnip
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/d/OneDrive/mysnips/"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "/d/OneDrive/mysnips/"]

"" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1

"" Vimwiki 
let g:vimwiki_list = [{'path': '/d/OneDrive/mywiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
"" Nedtree 
map <c-d> :NERDTreeToggle<CR>

"" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"" Silver search ag with Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"" vim-illuminate
hi link illuminatedWord Visual

"" Vebugger
let g:vebugger_use_tags=1

"" Vim-lsp 
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': 'X'}
if executable('jdtls')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'jdtls',
    \ 'cmd': {server_info->['jdtls']},
    \ 'whitelist': ['java'], 
    \ })
    autocmd FileType java nnoremap <buffer><silent> <c-]>  :LspDefinition<cr>
    autocmd FileType java nnoremap <buffer><silent> K :LspHover<cr>
    autocmd FileType java nnoremap <leader>f :LspCodeAction<cr>
endif

if executable('kls')
    au User lsp_setup call lsp#register_server({
    \ 'name': 'kls',
    \ 'cmd': {server_info->['kls']},
    \ 'whitelist': ['kotlin'], 
    \ })
    autocmd FileType kotlin nnoremap <buffer><silent> <c-]>  :LspDefinition<cr>
    autocmd FileType kotlin nnoremap <buffer><silent> K :LspHover<cr>
    autocmd FileType kotlin nnoremap <leader>f :LspCodeAction<cr>
endif

if executable('javascript-typescript-stdio')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'javascript-typescript-stdio',
                \ 'cmd': {server_info->['javascript-typescript-stdio']},
                \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
                \ 'whitelist': ['javascript', 'javascript.jsx'],
                \ })
endif
""
""" for vim-lsp log
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

"" asyncomplete
""" logs
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
""" auto popup completion
let g:asyncomplete_auto_popup = 1
""" force refresh
imap <c-x><space> <Plug>(asyncomplete_force_refresh)
""" asyncomplete with ultisnip source 
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-e>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif
""" asyncomplete with file source 
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
""" asyncomplete with buffer source 
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
""fzf completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" }}}

" Colors & Theme {{{
syntax on
colorscheme molokai
set hlsearch
" colorscheme cobalt2
" }}}

" Tabs & Spaces {{{ 
set nocompatible
set expandtab                      	"convert tab to spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2
" }}}

" Folding {{{
set foldenable
set foldmethod=indent
" }}}

" File searching {{{
set path+=**         			    " search files recursively
set wildmenu                        " displays the matched files when fuzzy searching  
" }}}

" Key mappings {{{ 
" replace ESC with 'jk'  
inoremap jk <ESC>
inoremap JK <ESC>
inoremap <esc> <nop>
inoremap <BS> <nop>
" set leader key to ',' 
let mapleader="," 
let maplocalleader="\\"
" shortcut to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

""Auto completion for braces, blackets and quotation marks 
" nnoremap <leader>" bi"<esc>ea"
" nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{  }}<esc>2hi
inoremap {% {%  %}<esc>2hi
inoremap {!! {!!  !!}<esc>3hi

"vim-surround
nmap <leader>qq ysiw" 
nmap <leader>qs ysiw' 
nmap <leader>qt ysiw` 

"" Tag a line as sction in vimwiki
nnoremap <leader>ts 0d$i[<esc>pa](#<esc>pa)<esc>F]

"" Input code block in vimwiki
inoremap ``` ```<cr>```<esc>O

" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>

" Denite
" nnoremap <c-f> :Denite file/rec<cr>
nnoremap <c-f> :FZF<cr>

" vim-vebugger
let g:vebugger_leader="<Leader>d"
nnoremap <Leader>da :call vebugger#jdb#attach('5005', {'srcpath': 'src/main/java'})

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" }}}

" Augroups {{{ 
augroup java_spaces
    autocmd!
    autocmd filetype java setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

" }}} 

" Statusline {{{ 
set statusline=
set statusline+=\ Branch:
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ \     
set statusline+=\ File:
set statusline+=\ %f
set statusline+=\ \  
set statusline+=\ Line: 
set statusline+=%l    " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines
set statusline+=\ \  
set statusline+=\ Col: 
set statusline+=%c   " Total lines
" Syntastic
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}} 

" Misc {{{
set number
set relativenumber
set ruler
set spellfile=/d/OneDrive/vim_spell/en.utf-8.add
filetype plugin indent on
"" Always show status line, disable with value of 0 
set laststatus=2

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0 
