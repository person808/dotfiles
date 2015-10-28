" Buffer settings
setlocal omnifunc=jedi#completions
setlocal textwidth=99
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
" Plugin settings
let g:neomake_python_enabled_checkers = ['flake8', 'pep8']
let b:delimitMate_nesting_quotes = ['"']
