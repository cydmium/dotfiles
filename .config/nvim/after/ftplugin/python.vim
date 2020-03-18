setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=syntax
" setlocal textwidth=79
" Fold docstrings
setlocal foldenable
setlocal foldmethod=syntax
setlocal foldlevel=0
augroup python_files
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end
