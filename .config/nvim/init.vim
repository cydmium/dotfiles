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
nnoremap ,f :Explore<cr>

""" Visualization Options
set showmatch	" Show matching parens/brackets/braces

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
nnoremap ,b :buffers<cr>:buffer<space>
set hidden	" Allow switching buffers without writing
" Split tend towards bottom right corner
set splitright
set splitbelow

""" File Formatting
filetype plugin indent on
set autoindent

""" Extra Options
set modelines=1
