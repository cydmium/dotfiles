"" Plugins
""" Automatically add vim-plug if not installed
if has('nvim')
  let s:plugpath='~/.config/nvim/autoload/plug.vim'
  let g:python_host_prog = '~/.pyenv/versions/2.7.16/envs/tools2/bin/python'
  let g:python3_host_prog = '~/.pyenv/versions/3.7.3/envs/tools3/bin/python'
else
  let s:plugpath='~/.vim/autoload/plug.vim'
endif
if empty(glob(s:plugpath))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Plugin List
if has('nvim')
	call plug#begin('~/.config/nvim/plugged')
else
	call plug#begin('~/.vim/plugged')
endif
" Colorscheme(s)
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
" Airline - Beautify the status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Vinegar - Better netrw
Plug 'tpope/vim-vinegar'
" Commentary - Easy comments
Plug 'tpope/vim-commentary'
" Vim-Surround - Change surrounding characters
Plug 'tpope/vim-surround'
" Vim-Repeat - . repeats last tpope command
Plug 'tpope/vim-repeat'
" Ultisnips - Snippet Engine
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" DelimitMate - Autocomplete matching pairs
Plug 'Raimondi/delimitMate'
" Rainbow Parentheses - Visualize nested parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" FZF - Fuzzy Searching
Plug 'junegunn/fzf.vim'
" Goyo - Distraction free editor
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
" Conquer of Completion - LSP Plugin + Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Vimtex - Best Latex support
Plug 'lervag/vimtex', {'for': 'tex'}

call plug#end()
""" Configuration
"""" Goyo
nnoremap ,g :Goyo<cr>
augroup goyo_mode
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
  autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
augroup end
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
"""" Snippets
" imap <c-j> <plug>(coc-snippets-expand-jump)
" vmap <c-j> <plug>(coc-snippets-select)
"let g:coc_snippet_next = '<c-j>'
"let g:coc_snippet_prev = '<c-k>'
imap <plug>(coc-snippets-expand-jump) <nop>
imap <plug>(coc-snippets-expand) <nop>
let g:UltiSnipsExpandTrigger='<c-j>'
let g:ultisnips_python_style='numpy'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
"""" Fuzzy Finding
nnoremap ,b :Buffers<cr>
nnoremap ,f :Files<cr>
nnoremap ,t :Tags<cr>
nnoremap ,gf :GFiles<cr>
"""" Delimit Mate
let delmitMate_expand_space=1
let delimitMate_jump_expansion=1
"""" CoC
" Usage tab for completion
inoremap <silent><expr> <tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Confirm completion with <cr>
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap ,rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap ,qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Remappings
""" Quality of Life
" Better escape
inoremap jk <esc>
" Make j/k behave as expected
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'
" Split Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

""" Additional Functionality
" Quickly edit vimrc
nnoremap ,ev :edit $MYVIMRC<cr>
nnoremap ,sv :source $MYVIMRC<cr>
" Open file browser
nnoremap ,ex :Explore<cr>
" Repeat Tabbing
vnoremap ,> >gv
vnoremap ,< <gv
" Copy/Paste to/from system clipboard
vnoremap ,y "+y
nnoremap ,y "+y
nnoremap ,p "+p
nnoremap ,P "+P
" Delete/change to empty register
nnoremap ,d "_d
nnoremap ,c "_c
vnoremap ,d "_d
vnoremap ,c "_c
" Spell check toggle
nnoremap ,sc :setlocal spell! spelllang=en_us<cr>
inoremap ,sc <esc>:setlocal spell! spelllang=en_us<cr>i
" Turn off highlighting
nnoremap ,<space> :nohlsearch<cr>

"" User Interface
""" File Formatting
set autoindent
filetype plugin indent on
""" Beauty
" TODO: Do not set noshowmode unless airline is loaded
" Falls back to default
silent! colorscheme gruvbox
augroup beauty
    autocmd!
    autocmd BufEnter * call RainbowParenthesesCheck()
augroup end
" Setup Airline status bar
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
""" Cursor location visualization
set showmatch
set number
set relativenumber
set cursorline

"" User Experience
""" Automatically source vimrc
augroup vimrc
  autocmd!
  autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup end
""" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase
""" Folding
set foldenable
set foldnestmax=3
set foldlevelstart=4
""" Buffers
set hidden
" Tend towards bottom right corner
set splitright
set splitbelow
" set diffopt+=vertical
""" Completion
set wildmenu
set wildmode=longest,list,full
set complete+=kspell
set completeopt=menuone,longest,preview
""" Miscelaneous
set modelines=1
set backspace=indent,eol,start
set cmdheight=2
set updatetime=300
set shortmess+=c
