setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=syntax
augroup python_files
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
augroup end
if executable('pyls')
    let b:ale_linters = ['pyls']
    inoremap <expr> ,<tab> pumvisible() ? "<c-o>" : '<c-x><c-o><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
    let g:ale_python_pyls_config = {'pyls': 
                \ {'plugins': 
                \   {'pycodestyle': {'enabled': v:true},
                \    'pydocstyle': {'enabled': v:false},
                \    'pyflakes': {'enabled': v:true},
                \    'pylint': {'enabled': v:false},
                \    'mccabe': {'enabled': v:true}}},
                \ 'configurationSources': ['flake8']}
endif
setlocal omnifunc=ale#completion#OmniFunc
let b:ale_fixers = ['black']
