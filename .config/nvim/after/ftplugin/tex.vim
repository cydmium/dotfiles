setlocal spell
inoremap <c-l> <c-g>u<esc>[s1z=``<c-g>a
"inoremap <expr> ,<tab> pumvisible() ? "<c-p>" : '<c-x><c-o><c-r>=pumvisible() ? 
"       \ "\<lt>down>" : "<<c-p>"<cr>'
inoremap <expr> ,<tab> pumvisible() ? "<c-o>" : '<c-x><c-o><c-r>=pumvisible() ? "\<lt>down>" : ""<cr>'
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
"setlocal omnifunc=ale#completion#OmniFunc
setlocal conceallevel=1
augroup tex_files
    autocmd!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd InsertLeave,TextChanged *.tex update
    autocmd VimLeave *.tex !cleanLatex %
augroup end
