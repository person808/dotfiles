" Buffer settings
setlocal omnifunc=htmlcomplete#CompleteTags
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
