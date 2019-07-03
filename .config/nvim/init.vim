""" Plugins
" Automatically add vim-plug if not installed
if has('nvim')
	let s:plugpath='~/.config/nvim/autoload/plug.vim'
        let g:python_host_prog='/home/david/.pyenv/versions/neovim2/bin/python'
        let g:python3_host_prog='/home/david/.pyenv/versions/neovim3/bin/python'
else
	let s:plugpath='~/.vim/autoload/plug.vim'
endif
if empty(glob(s:plugpath))
  silent !curl -fLo s:plugpath --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
	call plug#begin('~/.config/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif

" Git is good
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Better netrw
Plug 'tpope/vim-vinegar'
" Better start screen - TODO: Setup sessions that are of interest
Plug 'mhinz/vim-startify'
" Linter and Language Server Protocol Implementation - TODO: Setup for LaTeX
let g:ale_completion_enabled=1
Plug 'w0rp/ale'
let g:ale_lint_on_text_changed='never'
" Snippets - TODO: Move good vim-snippets to personal dir and remove rest
Plug 'SirVer/ultisnips'
" Comment Plugin
Plug 'tpope/vim-commentary'
"Plug 'honza/vim-snippets'
" Autocomplete matching pairs
Plug 'Raimondi/delimitMate'
"let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimiteMate_jump_expansion=1
" FZF
Plug 'junegunn/fzf.vim'
" TODO: Look into various comment plugins
" Status bar must look beautiful
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Colorscheme
Plug 'morhetz/gruvbox'
" Show Rainbow Parenthesis
Plug 'junegunn/rainbow_parentheses.vim'
" Tag handling
Plug 'ludovicchabant/vim-gutentags'
" Better Markdown highlighting
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" LaTeX Engine
Plug 'lervag/vimtex', { 'for': 'tex' }
" Beautified prose editor
Plug 'junegunn/goyo.vim', {'on': 'Goyo' }

call plug#end()

""" Remappings
" Better escape
inoremap jk <esc>

" Make j/k behave as expected
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

" Quickly edit vimrc
nnoremap ,ev :edit $MYVIMRC<cr>
nnoremap ,sv :source $MYVIMRC<cr>

" Open file browser
nnoremap ,ex :Explore<cr>

" Repeat Tabbing
vnoremap ,> >gv
vnoremap ,< <gv

" Spell check
nnoremap ,sc :setlocal spell! spelllang=en_us<cr>
inoremap ,sc <esc>:setlocal spell! spelllang=en_us<cr>i

" Split Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Copy to system clipboard
vnoremap ,y "*y
nnoremap ,y "*y
nnoremap ,p "*p
nnoremap ,P "*P

" Delete/change to empty buffer
nnoremap ,d "_d
nnoremap ,c "_c
vnoremap ,d "_d
vnoremap ,c "_c

""" Visualization Options
set showmatch	" Show matching parens/brackets/braces
set number
set relativenumber
set cursorline

""" Search Options
set incsearch       " Search as you type
set hlsearch        " Highlights search matches
set ignorecase      " Case insensitive
set smartcase       " Case sensititve if using caps
" Turn off highlighting
nnoremap ,<space> :nohlsearch<cr>

""" Fold Settings
set foldenable
set foldnestmax=5	" Max of 5 folds deep
set foldlevelstart=6	" Start 1 fold over max (all open by default)

""" Buffers
" List open buffers and allow selection
set hidden	" Allow switching buffers without writing
" Split tend towards bottom right corner
set splitright
set splitbelow

""" File Formatting
set autoindent
filetype plugin indent on

""" Autocompletion
set wildmenu
set wildmode=longest,list,full
set complete+=kspell
set completeopt=menuone,longest,preview
" Easier complete mode commands (removes ctrl requirements)
" TODO: Find a better way to write all of these so I can reuse them
" TODO: Rewrite ,<tab> to try completers until it finds one that's not empty
" These mappings are complex, so a simpler explanation is below
" if pop-up completion menu is already open:
"       cycle through with ctrl+letter
" else:
"       run command to open completion menu
"       if pop-up completion menu is open:
"               select first item, but do not put it in the file
"       else:
"               do nothing
inoremap <expr> ,,n pumvisible() ? "<c-n>" : '<c-x><c-n><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,,p pumvisible() ? "<c-p>" : '<c-x><c-p><c-r>=pumvisible() ? "\<lt>up>" : ""<cr>'
inoremap <expr> ,,k pumvisible() ? "<c-k>" : '<c-x><c-k><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,,] pumvisible() ? "<c-]>" : '<c-x><c-]><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,,d pumvisible() ? "<c-d>" : '<c-x><c-d><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,,u pumvisible() ? "<c-u>" : '<c-x><c-u><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,,o pumvisible() ? "<c-o>" : '<c-x><c-o><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> ,<tab> pumvisible() ? "<c-p>" : '<c-x><c-p><c-r>=pumvisible() ? "\<lt>up>" : ""<cr>'
" ctrl+l does not cooperate with selected completion items
inoremap ,,l <c-x><c-l>
" Let generic ctrl+n/p work the same as the completion mode remappings
inoremap <expr> <c-n> pumvisible() ? "<c-n>" : '<c-n><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
inoremap <expr> <c-p> pumvisible() ? "<c-p>" : '<c-p><c-r>=pumvisible() ? "\<lt>up>" : ""<cr>'
" Let tab cycle completion pop-up
imap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "<plug>delimitMateS-Tab"
" Enter selects item - Must use imap here to work with <plug>
"inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "<c-g>u\<cr>"
imap <expr> <cr> pumvisible() ? "\<c-y>" : "<c-g>u<Plug>delimitMateCR"

""" Extra Options
set modelines=1
set backspace=indent,eol,start	" Make backspace work like expected

""" Autocommands
augroup all_files
    autocmd!
    " autocmd Filetype * setlocal formatoptions-=ro   " Don't auto-add comment characters on new lines
augroup end

augroup vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup END

augroup x11
    autocmd!
    autocmd bufwritepost *Xresources,*Xdefaults !xrdb %
augroup end

""" Beauty
colorscheme gruvbox
augroup beauty
    autocmd!
    autocmd BufEnter * RainbowParentheses
augroup end
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols={}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = 'Ξ'
set noshowmode

""" goyo changes
nnoremap ,g :Goyo<cr>
function! s:goyo_enter()
    " Goyo exits on :q if it is the only open buffer
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    set nonumber norelativenumber
    set linebreak
endfunction

function! s:goyo_leave()
    " Goyo exits on :q if it is the only open buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
    colorscheme gruvbox
    set nolinebreak
    set number relativenumber
endfunction

augroup goyo_mode
    autocmd!
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
    autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
augroup end

""" Snippets
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
setlocal completefunc=snipcomp#ListSnippets

""" FZF
nnoremap ,b :Buffers<cr>
nnoremap ,f :Files<cr>
nnoremap ,t :Tags<cr>
nnoremap ,gf :GFiles<cr>
command! W write " Overwrite :W corresponding to windows

""" Backup, Swap, and Undo file cleanliness
set backupdir=.backup/,~/.backup//,/tmp//
set directory=.swp/,~/.swp//,/tmp//
set undodir=.undo/,~/.undo//,/tmp//
" set undofile  " Persistent Undos
