setlocal expandtab
autocmd BufWritePre * :%s/\s\+$//e
let g:autopep8_max_line_length = 159  " Allow longer line lengths
