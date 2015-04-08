" Buffer settings
setlocal omnifunc=xmlcomplete#CompleteTags
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
