" Buffer settings
setlocal omnifunc=jedi#completions
setlocal textwidth=99
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
" Plugin settings
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = 2
let g:jedi#force_py_version = 3
" Use jedi for neocomplete
let g:neocomplete#force_omni_input_patterns.python =
	\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_checkers = ['prospector']
let g:syntastic_python_prospector_args = "-F --max-line-length 99"
