setlocal expandtab  " Use spaces instead of tabs
autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
let g:autopep8_max_line_length = 159  " Allow longer line lengths
