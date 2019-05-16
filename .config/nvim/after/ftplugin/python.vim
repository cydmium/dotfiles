setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=79
setlocal colorcolumn=80
setlocal foldmethod=syntax
augroup python_files
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    if executable('pyls')
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'pyls',
                    \ 'cmd': {server_info->['pyls']},
                    \ 'whitelist': ['python'],
                    \ })
        setlocal omnifunc=lsp#omni#complete
    endif
augroup end
