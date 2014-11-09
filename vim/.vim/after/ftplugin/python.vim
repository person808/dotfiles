setlocal expandtab
autocmd BufWritePre * :%s/\s\+$//e
