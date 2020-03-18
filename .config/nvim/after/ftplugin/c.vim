setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
augroup c_files
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end
