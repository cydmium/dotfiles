""" Plugins
" Automatically add vim-plug if not installed
if has('nvim')
	let s:plugpath='~/.config/nvim/autoload/plug.vim'
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
" Unix commands
Plug 'tpope/vim-eunuch'
" Better netrw
Plug 'tpope/vim-vinegar'
" Better start screen
Plug 'mhinz/vim-startify'
" Status bar must look beautiful
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" FZF
Plug 'junegunn/fzf.vim'
" Language Server Protocol support
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Colorscheme
Plug 'morhetz/gruvbox'
"
" Better Markdown highlighting
Plug 'plasticboy/vim-markdown', { 'for': 'markdown'}
" Beautified prose editor
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}

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
vnoremap ,y "+y
nnoremap ,yy "+yy
nnoremap ,p "+p
nnoremap ,P "+P

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
filetype plugin indent on
set autoindent

""" Autocompletion
set wildmenu
set wildmode=longest,list,full
set complete+=kspell

""" Extra Options
set modelines=1
set backspace=indent,eol,start	" Make backspace work like expected

""" Autocommands
augroup all_files
    autocmd!
    autocmd Filetype * setlocal formatoptions-=ro   " Don't auto-add comment characters on new lines
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
let g:airline#extensions#tabline#enabled = 1
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
    autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
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
