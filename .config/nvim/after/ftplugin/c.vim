setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal omnifunc=ale#completion#OmniFunc
if executable('clang-format')
    let b:ale_fixers = ['clang-format']
endif
inoremap <expr> ,<tab> pumvisible() ? "<c-o>" : '<c-x><c-o><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
augroup c_files
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end
