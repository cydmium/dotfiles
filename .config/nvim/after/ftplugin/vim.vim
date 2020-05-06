setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
" Setup Folding
setlocal foldmethod=expr
setlocal foldlevel=0
setlocal foldexpr=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-2)\:'='
