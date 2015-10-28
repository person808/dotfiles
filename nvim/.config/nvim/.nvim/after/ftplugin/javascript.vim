" Buffer settings
setlocal omnifunc=javascriptcomplete#CompleteJS
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
