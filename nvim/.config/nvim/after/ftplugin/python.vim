" Buffer settings
setlocal omnifunc=jedi#completions
setlocal textwidth=99
" Plugin settings
let g:neomake_python_enabled_checkers = ['flake8', 'pep8']
let b:delimitMate_nesting_quotes = ['"']
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 0
