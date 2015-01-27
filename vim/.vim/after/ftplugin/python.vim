" Buffer settings
setlocal omnifunc=jedi#completions
setlocal textwidth=99
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
" Plugin settings
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_checkers = ['prospector']
let g:syntastic_python_prospector_args = "-F --max-line-length 99"
let b:delimitMate_nesting_quotes = ['"']
