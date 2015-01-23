" Plugins {{{
call plug#begin('~/.vim/plugged')
" Gui plugins
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'w0ng/vim-hybrid'
Plug 'Yggdroot/indentLine'
" Add features
Plug 'Chiel92/vim-autoformat'
Plug 'haya14busa/incsearch.vim'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
" Editing
Plug 'junegunn/vim-easy-align'
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
" Autocomplete
Plug 'cohama/lexima.vim'
Plug 'honza/vim-snippets'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/UltiSnips'
" Unite
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
" Python
Plug 'davidhalter/jedi-vim'
" Fish
Plug 'dag/vim-fish'
call plug#end()
" }}}

" Misc {{{
set shell=bash
set history=1000
set undolevels=10000
set undofile
set undodir=$HOME/.vim/undo
set backspace=indent,eol,start
set clipboard=unnamedplus
set mouse=a
set ttymouse=xterm2
set lazyredraw
set ttyfast
set updatetime=200
set timeoutlen=1000 ttimeoutlen=10
set confirm
set virtualedit=onemore
let g:plug_threads = 40

" Automatically change directory to the file's directory (set autochdir is
" incompatible with vimfiler)
augroup change_dir
	autocmd BufEnter * silent! lcd %:p:h
augroup END

" Opens files at the last known cursor position
augroup open_last_line
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" }}}

" User Interface {{{
set number
set cursorline
set showmatch
set laststatus=2
set showtabline=2
set showcmd
set scrolloff=5
set wrap
set linebreak
" Highlight past 80th column
execute "set colorcolumn=" . join(range(81,335), ',')
set wildmenu
set spell
set noshowmode
set shortmess+=c
let g:gundo_preview_bottom = 1

" Colorscheme {{{
set t_Co=256
let g:hybrid_use_Xresources = 1
colorscheme hybrid
" }}}

" Tabline/Statusline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%{getcwd()}'
" }}}
" }}}

" Indentation {{{
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set copyindent
set smarttab
set breakindent
let g:indentLine_char = '┊'
let g:indentLine_color_term = 102
" }}}

" Searching {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#consistent_n_direction = 1

" incsearch.vim keybindings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za
" }}}

" Misc Keybindings  {{{
" Built-in functions
let mapleader=","
let maplocalleader=",,"
inoremap jj <Esc>
nnoremap Y y$
" k and j don't skip wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" <Leader>s opens spelling corrections
nnoremap <Leader>s a<C-x><C-s><C-p>

" Plugins
nnoremap <Leader>u :GundoToggle<CR>
cnoremap w! SudoWrite
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)
nnoremap Q :Autoformat<CR><CR>
" }}}

" Buffers/Tabs/Splits {{{
set hidden
set splitbelow
set splitright

nnoremap <silent> <Leader>b :enew<CR>
nnoremap <silent> <Leader>l :bnext<CR>
nnoremap <silent> <Leader>h :bprevious<CR>
nnoremap <silent> <Leader>c :bdelete<CR>
" Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Git {{{
nmap ghn <Plug>GitGutterNextHunk
nmap ghp <Plug>GitGutterPreviousHunk
nmap ghs <Plug>GitGutterStageHunk
nmap ghr <Plug>GitGutterRevertHunk
nmap ghv <Plug>GitGutterPreviewHunk
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
" }}}

" Vimfiler {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

nnoremap <silent> <Leader>e :VimFilerExplorer -auto-cd -toggle -winwidth=30 -parent<CR>
" }}}

" Unite {{{
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
			\ 'auto_resize': 1,
			\ 'direction': 'botright',
			\ 'smartcase': 1,
			\ 'start_insert': 1,
			\ 'prompt': '>>> ',
			\ 'prompt_visible': 1,
			\ 'winheight': 10
			\ })
call unite#custom#profile('source/outline', 'context', {
			\ 'auto_resize': 0,
			\ 'prompt_direction': 'top',
			\ 'prompt_visible': 0,
			\ 'start_insert': 0,
			\ 'vertical': 1,
			\ 'winwidth': 40
			\ })

if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts =
				\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
				\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <Leader>f :Unite buffer file_mru file/async file_rec/async<CR>
nnoremap <Leader>y :Unite history/yank<CR>
nnoremap <Leader>o :Unite outline<CR>
nnoremap <Leader>g :Unite grep<CR>
" }}}

" Autocomplete/Snippets {{{
" Global settings {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 30
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#enable_camel_case = 1
call neocomplete#custom#source('ultisnips', 'rank', 1000)

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

" Initialize variable to allow custom omnicomplete patterns
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
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

" Keybindings {{{
" <Tab> cycles completes common string and cycles through completions
inoremap <expr><TAB>
		\ neocomplete#complete_common_string() != '' ?
		\   neocomplete#complete_common_string() :
		\ pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <CR> inserts completion
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
" }}}
" }}}

" Syntastic {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
augroup syntastic
	autocmd CursorHold * nested update
augroup END
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
