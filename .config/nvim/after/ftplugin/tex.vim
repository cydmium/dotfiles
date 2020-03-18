setlocal spell
inoremap <c-l> <c-g>u<esc>[s1z=``<c-g>a
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal conceallevel=1
augroup tex_files
  autocmd!
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd InsertLeave,TextChanged *.tex update
  autocmd VimLeave *.tex !cleanLatex %
augroup end
