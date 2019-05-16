setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79
setlocal colorcolumn=80
augroup c_files
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    if executable('ccls')
       autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'ccls',
          \ 'cmd': {server_info->['ccls']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
          \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
          \ })
        setlocal omnifunc=lsp#omni#complete
    endif
augroup end
