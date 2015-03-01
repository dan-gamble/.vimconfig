" don't want compatibility with Vi  
set nocompatible

" Vim {{{

" set encoding
set encoding=utf-8
" make vim check the last line for file specific settings
set modelines=1
" change file to match external changes (i.e after a git merge)
set autoread
" yanks go to the clipboard
set clipboard=unnamed
" show command in the bottom bar
set showcmd
" redrawn(?) only when we need to. Improves performance
set lazyredraw
" show matching braces, brackets etc.
set showmatch
set matchtime=3 " match for 3s(?)
" show status bar
set laststatus=2
" get vim to autoindent based on file indentation, hopefully...
set autoindent
" set defaults for split panes
set splitbelow
set splitright
set colorcolumn=+1
" return to line open before last close
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 9 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Mappings {{{

" set leader to be the comma `,`
let mapleader = ","
" set the local map leader(?)
let maplocalleader = "\\"

" unbind F1 help key
noremap <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" }}}

" }}}
" Backups {{{

" enable backups
set backup
" we don't want the swp file
set noswapfile

" set backup directories
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" lets make the above folders if they don't exist
if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
        call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
        call mkdir(expand(&directory), 'p')
endif

" }}}
" Completion {{{

set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" }}}
" Cursorline {{{

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Folding {{{

" we want to be able to fold
set foldenable
" open most folds by default
set foldlevelstart=10
" nested fold max level
set foldnestmax=10
" fold method
set foldmethod=indent

" {{{ Mappings

" define `,` to open and close folds
nnoremap <space> za

" }}}
" }}}
" Line {{{

" set numbers to be relative to current line
set relativenumber
" turn on line numbers, we do this after relativenumber so the current line
" has it's number
set number
" highlight current line
set cursorline

" }}}
" Movement {{{

" fix vim backspace
set backspace=indent,eol,start

" Mappings {{{

" move vertically by visual line (won't skip wrapped lines)
nnoremap j gj
nnoremap k gk

" move to the beginning and end of line
nnoremap B ^
nnoremap E $
" make sure the old keybinds for these do diddly
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" enter normal mode aka do <esc>
inoremap jk <esc>

" }}}

" }}}
" Searching {{{

" search as characters are entered
set incsearch
" highlight matches
set hlsearch
" ignore case sensitivity
set ignorecase
" we want smartcase though
set smartcase
" replace on line by default
set gdefault

" Mappings {{{

" clear search highlights
nnoremap <leader><space> :nohlsearch<CR>

" }}}

" }}}
" System + Shortcuts to common files i.e .vimrc, .zshrc {{{

" Mappings {{{ 

" .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
" .zshrc
nnoremap <leader>ez :vsp ~/.zshrc<CR>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" save session (window layouts, open files etc.)
nnoremap <leader>s :mksession<CR>

" }}}

" }}}
" {{{ Tabs

" number of visual spaces per tab
set tabstop=4
" number of spaces in tab when editing
set softtabstop=4
" come on now, tabs are spaces..
set expandtab
" set indent to use multiple of shiftwidth
set shiftwidth=4
set shiftround

" }}}
" Terminal specific settings {{{

" time out on key codes but not mappinhs
set notimeout
set ttimeout
set timeoutlen=10

" }}}
" {{{ Theme

" we want syntax..
syntax enable
" we also prefer dark styles
set background=dark
" my current favourite theme atm
colorscheme gruvbox

" }}}
" Wildmenu {{{

" visual autocomplete for command menu
set wildmenu
set wildmode=list:longest
" add some things to ignore
set wildignore+=.hg,.git,.svn
set wildignore+=.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.DS_STORE
set wildignore+=migrations
set wildignore+=*.pyc
set wildignore+=*.sass-cache

" }}}
" Whitespace {{{

" show white space
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮

" only show whitespace when not in insert mode
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}

" File specific {{{

" CSS {{{

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less
    au BufNewFile,BufRead *.scss setlocal filetype=scss

    au Filetype less,scss,css setlocal foldmethod=marker
    au Filetype less,scss,css setlocal foldmarker={,}
    au FileType less,scss,css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType less,scss,css setlocal iskeyword+=-

    " make the curson position properly when opening braces
    au BufNewFile,BufRead *.less,*.scss,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    " }
augroup END

" }}}
" Django {{{

augroup ft_django
    au!

    au BufNewFile,BufRead urls.py         setlocal nowrap
    au BufNewFile,BufRead urls.py         normal! zR
    au BufNewFile,BufRead dashboard.py    normal! zR
    au BufNewFile,BufRead local.py        normal! zR

    au BufNewFile,BufRead admin.py        setlocal filetype=python.django
    au BufNewFile,BufRead urls.py         setlocal filetype=python.django
    au BufNewFile,BufRead models.py       setlocal filetype=python.django
    au BufNewFile,BufRead views.py        setlocal filetype=python.django
    au BufNewFile,BufRead settings.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py     setlocal foldmethod=marker
    au BufNewFile,BufRead forms.py        setlocal filetype=python.django
augroup END

" }}}
" HTML, Django, Jinga {{{

let g:html_indent_tags = ['p', 'li']

augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango

    au FileType html,jinja,htmldjango setlocal foldmethod=manual

    " use localleader to fold current tag
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

    " use localleader to fold the current templatetag
    au FileType html,jinja,htmldjango nmap <buffer> <localleader>t viikojozf

    " indent tag
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>= Vat=

    " django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-b> {{<space><space>}}<left><left><left>
augroup END

" }}}
" Javascript {{{

augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript setlocal call MakeSpacelessBufferIabbrev('clog', 'console.log();<left><left>')

    " make the curson position properly when opening braces
    au FileType javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    " }

    " prettyify dat json
    au FileType javascript nnoremap <buffer> <localleader>p Bvg_:!python -m json.tool<cr>
    au FileType javascript vnoremap <buffer> <localleader>p :!python -m jston.tool<cr>

augroup END

" }}}
" Python {{{

augroup ft_python
    au!

    au FileType python setlocal define=^\s*\\(def|||||class\\)

    au FileType python if exists('python_space_error_highlight') | unlet python_space_error_highlight | endif
augroup END

" }}}

" }}}

" Plugins (Vundle) {{{

" Before plugins {{{

" required for Vundle
filetype off

" set the runtime path to invlude Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim "requied
call vundle#begin() " required

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim' " required

" }}}
" list of other plugins {{{

" airline | adds a super sext status bar {{{

Plugin 'bling/vim-airline'

" }}}
" ag | vim plugin for the silver searcher {{{

Plugin 'rking/ag.vim'

" }}}
" ack | searchy stuff {{{

Plugin 'mileszs/ack.vim'

nnoremap <leader>a :Ack!<space>
let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'

" }}}
" autoclose | trigger autoclosing for certain characters {{{

Plugin 'Townk/vim-autoclose'

" Mappings {{{

nmap <leader>x <Plug>ToggleAutoCloseMappings

" }}}

" }}}
" commentary | lets comment stuff out proper! {{{{{

Plugin 'tpope/vim-commentary'

augroup plugin_commentary
    au!
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
augroup END

" Mappings {{{

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

" }}}

" }}}
" ctrlP | fuzzy search file opening {{{

Plugin 'kien/ctrlp.vim'

" order files top to bottom
let g:ctrlp_match_window = 'bottom, order:ttb'
" always open file in new buffer
let g:ctrlp_switch_buffer = 0
" if we change working directory in vim respect that
let g:ctrlp_working_path_mode = 0
" make ctrlp use ag to search (much quicker)
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>E :CtrlP ../

let g:ctrlp_map = '<leader>,'

" }}}
" easy align {{{

Plugin 'junegunn/vim-easy-align'

" Mappings {{{

" start interactive EasyAlign in visualmode (e.g vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g gaip)
nmap ga <Plug>(EasyAlign)

" }}}

" }}}
" gundo | sexy undo history {{{

Plugin 'sjl/gundo.vim'

let g:gundo_debug = 1
let g:gundo_preview_bottom = 1
let g:gundo_tree_statusline = "Gundo"
let g:gundo_preview_statusline = "Gundo Preview"

" Mappings {{{

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" }}}

" }}}
" indentLine {{{

Plugin 'Yggdroot/indentLine'

" }}}
" HTML5 {{{

Plugin 'othree/html5.vim'

let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" }}}
" MatchTagAlways | shows what HTML tags we are in {{{

Plugin 'valloric/MatchTagAlways'

" }}}
" python-mode {{{

Plugin 'klen/python-mode'

let g:pymode_doc = 1
let g:pymode_doc_key = 'M'
let g:pydoc = 'pydoc'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 0
let g:pymode_syntax_builtin_objs = 1
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_space_errors = 0

let g:pymode_run = 0
let g:pymode_breakpoint = 0

let g:pymode_options_indent = 0

let g:pymode_rope = 1
let g:pymode_rope_global_prefix = '<localleader>R'
let g:pymode_rope_local_prefix = '<localleader>r'
let g:pymode_rope_enable_autoimport = 0

" }}}
" splitjoin {{{

Plugin 'AndrewRadev/splitjoin.vim'

" }}}
" supertab | helps with autocompletions! {{{

Plugin 'ervandew/supertab'

" }}}
" scss-syntax | proper scss syntax highlighting {{{

Plugin 'cakebaker/scss-syntax.vim'

" }}}
" vim-javascript {{{

Plugin 'pangloss/vim-javascript'

" }}}
" xml.vim | helps refactor html tags {{{

Plugin 'othree/xml.vim'

" }}}

" Colors {{{

Plugin 'whatyouhide/vim-gotham'

" }}}

" }}}
" After plugins {{{

" all plugins must be before this line
call vundle#end() " required
filetype plugin indent on " required

" }}}

" }}}

" specifics to .vimrc
" #-- Make sure foldings are markers and are all collapsed by default
" vim:foldmethod=marker:foldlevel=0