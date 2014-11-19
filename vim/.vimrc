" Plugins {{{
call plug#begin('~/.vim/plugged')
" Gui plugins
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'zefei/cake16'
Plug 'godlygeek/csapprox'
Plug 'ap/vim-buftabline'
" Add features
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/bufkill.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimshell.vim'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl'
Plug 'tpope/vim-eunuch'
" Editing
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
" Autocomplete
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neocomplete.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/UltiSnips'
" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'kopischke/unite-spell-suggest'
" Python
Plug 'tell-k/vim-autopep8', {'for': 'python'}
" Fish
Plug 'dag/vim-fish', {'for': 'fish'}
call plug#end()
" }}}

" Misc {{{
set nocompatible
set shell=bash  " Set shell to bash for compatibility
set history=1000  " Remember more commands and search history
set undolevels=10000  " Remember more undo levels
set undofile  " Save undo history between sessions
set undodir=$HOME/.vim/undo  " Save undo history in custom folder
set backspace=indent,eol,start  " Backspace over everything in insert mode
set clipboard=unnamedplus  " Use system clipboard
set mouse=a  " Mouse support
set ttymouse=xterm2  " Make sure the mouse works
set lazyredraw  " Redraw only when necessary for better performance
set ttyfast  " Improve performance
set updatetime=1000  " Lower updatetime for faster git gutter updates
set confirm  " Ask if I want to save the file when I quit instead of failing when there are unsaved changes
" Automatically change directory to the file's directory (set autochdir is
" incompatible with vimfiler)
augroup change_dir
	autocmd BufEnter * silent! lcd %:p:h
augroup END
let g:plug_threads = 30  " Update more plugins at once
" }}}

" User Interface {{{
" Show line numbers in current window
set number
augroup set_number
	autocmd WinEnter * setlocal number
	autocmd WinLeave * setlocal nonumber
augroup END
set cursorline  " Highlight line the cursor is on
set showmatch  " Show matching parentheses
set laststatus=2  " Always show status
set showtabline=2  " Always show tab bar
set showcmd  " Show information about current command
set scrolloff=5  " Always show 5 lines below cursor
set wrap  " Enable line wrapping
set linebreak  " Don't wrap lines on words
set wildmenu  " Show completions for command mode
set spell  " Spell check

" Colorscheme {{{
set t_Co=256  " Use 256 terminal colors
colorscheme cake16  " Set terminal colorscheme
" Underline misspelled words
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi SpellBad cterm=underline
hi SpellCap cterm=underline
" }}}

" Tabline/Statusline {{{
let g:buftabline_indicators = 1  " Show buffer state in buffer label
" Statusline settings
autocmd BufWinEnter,WinEnter,VimEnter * let w:getcwd = getcwd()
let &statusline = " %{StatuslineTag()} "
let &statusline .= "\ue0b1 %<%f "
let &statusline .= "%{&readonly ? \"\ue0a2 \" : &modified ? '+ ' : ''}"
let &statusline .= "%=\u2571 %{&filetype == '' ? 'unknown' : &filetype} "
let &statusline .= "\u2571 %l:%2c \u2571 %p%% "
function! StatuslineTag()
	if exists('b:git_dir')
		let dir = fnamemodify(b:git_dir[:-6], ':t')
		return dir." \ue0a0 ".fugitive#head(7)
	else
		return fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
	endif
endfunction
" }}}
" }}}

" Indentation {{{
filetype plugin indent on  " Load filetype specific indent files
set tabstop=4  " Tabs width is 4
set shiftwidth=4  " Indents have a width of four
set softtabstop=4  " Use four columns for tabs
set autoindent  " Always set autoindenting on
set copyindent  " Copy previous indentation when autoindenting
set smarttab  " Insert tabs on the start of a line using shiftwidth
set breakindent  " Make line wrapping respect indentation
let g:indentLine_char = '┊'  " Use Sublime Text style indent guides
let g:indentLine_color_term = 102  " Set indent guide color
" }}}

" Searching {{{
set ignorecase   " Ignore case when searching
set smartcase   " Ignore case if search pattern is all lowercase
set hlsearch  " Highlight search terms
set incsearch  " Show search matches as you type
" }}}

" Folding {{{
set foldenable  " Enable folding
set foldlevelstart=10  " Open most folds by default
set foldnestmax=10  " 10 nested folds max
set foldmethod=indent  " Fold based on indent level
" Space opens/closes folds
nnoremap <space> za
" }}}

" Misc Keybindings  {{{
" Remap leader to comma
let mapleader=","
" Map jj to <Esc>
inoremap jj <Esc>
" k and j don't skip wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" Open Gundo
nnoremap <Leader>u :GundoToggle<CR>
" Toggle indent guides
nnoremap <Leader>ig :IndentLinesToggle<CR>
" <Leader>c comments line
nnoremap <silent> <Leader>c :Commentary<CR>
vnoremap <silent> <Leader>c :Commentary<CR>
" :w! writes file with sudo
cnoremap w! SudoWrite
" }}}

" Buffers/Tabs/Splits {{{
set hidden  " Hide buffers instead of closing them
" Open a new empty buffer
nnoremap <silent> <Leader>b :enew<CR>
" Move to the next buffer
nnoremap <silent> <Leader>l :bnext<CR>
" Move to the previous buffer
nnoremap <silent> <Leader>h :bprevious<CR>
" Delete buffer
nnoremap <silent> <Leader>bd :bdelete<CR>
" Close buffer and preserve window layout
cnoremap bc BD
nnoremap <silent> <Leader>bc :BD<CR>

" More natural split opening
set splitbelow
set splitright

" Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Backups {{{
" Keep backups away from folders and in tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Vimfiler {{{
augroup vimfiler_close
	autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif  " Close vim if vimfiler is the only buffer
augroup END
let g:vimfiler_as_default_explorer = 1  " Vimfiler is the default file explorer
" Vimfiler icons
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
" <Leader>e toggles vimfiler
nnoremap <silent> <Leader>e :VimFilerExplorer -auto-cd -toggle -winwidth=30 -parent<CR>
" ? shows vimfiler help
nmap ? g?
" sh launches popup shell in vimfiler
nmap sh H
" }}}

" Vimshell {{{
" Vimshell prompt
let g:vimshell_prompt_expr =
		\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '
" Initialize execute file list.
let g:vimshell_execute_file_list = {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
let g:vimshell_execute_file_list['rb'] = 'ruby'
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['py'] = 'python'
call vimshell#set_execute_file('html,xhtml', 'gexe opera-beta')
" <Leader>sh opens vimshell
nnoremap <Leader>sh :VimShell<CR>
" <Leader>shp opens vimshell popup
nnoremap <Leader>shp :VimShellPop<CR>
" }}}

" Unite {{{
let g:unite_source_history_yank_enable = 1  " Enable yank history in unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])  " Fuzzy matching
call unite#filters#sorter_default#use(['sorter_rank'])  " Sort unite results
" Unite settings
call unite#custom#profile('default', 'context', {
		\'start_insert': 1,
		\'auto_resize': 1,
		\'winheight': 10,
		\'direction': 'botright',
		\'smartcase': 1,
		\'prompt': '>>> '
		\})
" <Leader>f opens unite
nnoremap <Leader>f :Unite buffer file_mru file/async file_rec/async<CR>
" <Leader>y opens unite yankring
nnoremap <Leader>y :Unite history/yank<CR>
" <Leader>o opens unite outline
nnoremap <Leader>o :Unite outline<CR>
" <Leader>o opens unite-spell-suggest
nnoremap <Leader>s :Unite spell_suggest<CR>
" }}}

" Autocomplete/Snippets {{{
" Neocomplete {{{
let g:neocomplete#enable_at_startup = 1  " Use neocomplete
let g:neocomplete#enable_smart_case = 1  " Use smart case in neocomplete
let g:neocomplete#max_list = 30  " Only show 30 suggestions
let g:neocomplete#enable_auto_delimiter = 1  " Automatically add delimiters
let g:neocomplete#enable_refresh_always = 1  " Always refresh completions (May cause slowdowns)
" <Tab> completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <CR> inserts completion
inoremap <expr><CR> neocomplete#close_popup()
" Enable omni completion.
augroup omnicompletion
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" Play nice with vim-multiple-cursors
function! Multiple_cursors_before()
	if exists(':NeoCompleteLock')==2
		execute 'NeoCompleteLock'
	endif
endfunction

function! Multiple_cursors_after()
	if exists(':NeoCompleteUnlock')==2
		execute 'NeoCompleteUnlock'
	endif
endfunction
" }}}

" UltiSnips settings {{{
" <CR> expands snippet
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
		return snippet
    else
		return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"  " Jump backwards in snippets with <s-tab>
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"  " Jump backwards in snippets with <s-tab>
" }}}
" }}}

" Syntastic {{{
let g:syntastic_check_on_open = 1  " Check for errors when opening file
let g:syntastic_aggregate_errors = 1  " Combine errors from multiple linters
let g:syntastic_python_python_exec = '/usr/bin/python3'  " Use python 3
let g:syntastic_python_checkers = ['prospector']  " Python linters
let g:syntastic_python_prospector_args = "-F"
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
