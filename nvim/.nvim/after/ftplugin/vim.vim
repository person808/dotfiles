" Buffer settings
setlocal keywordprg=:help
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
