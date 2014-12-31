" Buffer settings
setlocal omnifunc=csscomplete#CompleteCSS
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
