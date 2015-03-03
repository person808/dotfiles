" Buffer settings
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
