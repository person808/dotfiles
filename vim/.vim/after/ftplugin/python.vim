" Buffer settings
setlocal expandtab  " Use spaces instead of tabs
setlocal omnifunc=jedi#completions  " Omnicomplete
setlocal textwidth=99  " Set maximum line length
" Autocmds
augroup whitespace
	autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
" Plugin settings
let g:jedi#completions_enabled = 0  " Don't complete using jedi-vim
let g:jedi#auto_vim_configuration = 0  " Prevent jedi-vim from changing settings
let g:jedi#use_tabs_not_buffers = 0  " Open jedi command output in buffers
let g:jedi#show_call_signatures = 2  " Show call signatures in command line
let g:jedi#force_py_version = 3  " Use python 3
" Use jedi for neocomplete
let g:neocomplete#force_omni_input_patterns.python =
	\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:syntastic_python_python_exec = '/usr/bin/python3'  " Use python 3
let g:syntastic_python_checkers = ['prospector']  " Python linters
let g:syntastic_python_prospector_args = "-F --max-line-length 99"  " Prospector flags
