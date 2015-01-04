" Plugins {{{
call plug#begin('~/.vim/plugged')
" Gui plugins
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'w0ng/vim-hybrid'
" Add features
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/vimfiler.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'sheerun/vim-polyglot'
" Editing
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'sjl/gundo.vim'
" Autocomplete
Plug 'cohama/lexima.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/UltiSnips'
" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
" Python
Plug 'davidhalter/jedi-vim'
" Fish
Plug 'dag/vim-fish'
call plug#end()
" }}}

" Misc {{{
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
set timeoutlen=1000 ttimeoutlen=10  " Faster switching between modes
set confirm  " Confirm if I want to quit if there is an unsaved file
set virtualedit=onemore  " Allow cursor to move to EOL in normal mode

" Automatically change directory to the file's directory (set autochdir is
" incompatible with vimfiler)
augroup change_dir
	autocmd BufEnter * silent! lcd %:p:h
augroup END

let g:plug_threads = 40  " Update more plugins at once
" }}}

" User Interface {{{
" Show line numbers in current window
set number
set cursorline  " Highlight line the cursor is on
set showmatch  " Show matching parentheses
set laststatus=2  " Always show status
set showtabline=2  " Always show tab bar
set showcmd  " Show information about current command
set scrolloff=5  " Always show 5 lines below cursor
set wrap  " Enable line wrapping
set linebreak  " Don't wrap lines on words
" Highlight past 80th column
execute "set colorcolumn=" . join(range(81,335), ',')
set wildmenu  " Show completions for command mode
set spell  " Spell check
set noshowmode  " Don't show mode in command window
set shortmess+=c  " Don't show autocomplete messages in command line
let g:gundo_preview_bottom = 1  " Show gundo preview below windows

" Colorscheme {{{
set t_Co=256  " Use 256 terminal colors
let g:hybrid_use_Xresources = 1  " Use colors from .Xresources
colorscheme hybrid  " Set terminal colorscheme
" }}}

" Tabline/Statusline {{{
let g:airline_powerline_fonts = 1  " Use powerline symbols
let g:airline#extensions#tabline#enabled = 1  " Show buffers in tabline
let g:airline#extensions#tabline#fnamemod = ':t'  " Only show file name in tabline
let g:airline_section_c = '%{getcwd()}'  " Show current directory in statusline
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
let g:incsearch#auto_nohlsearch = 1  " Automatically turn off highlighting
let g:incsearch#consistent_n_direction = 1  " Make n and N consistent

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
set foldenable  " Enable folding
set foldlevelstart=10  " Open most folds by default
set foldnestmax=10  " 10 nested folds max
set foldmethod=indent  " Fold based on indent level
" Space opens/closes folds
nnoremap <space> za
" }}}

" Misc Keybindings  {{{
let mapleader=","
let maplocalleader=",,"
" Map jj to <Esc>
inoremap jj <Esc>
" k and j don't skip wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" <Leader>s opens spelling corrections
nnoremap <Leader>s a<C-x><C-s><C-p>
" Open Gundo
nnoremap <Leader>u :GundoToggle<CR>
" :w! writes file with sudo
cnoremap w! SudoWrite
" vim-easy-align keybindings
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)
" GQ formats code using vim-autoformat
nnoremap GQ :Autoformat<CR><CR>
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
nnoremap <silent> <Leader>c :bdelete<CR>

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
let g:vimfiler_as_default_explorer = 1  " Vimfiler is the default file explorer
" Vimfiler icons
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

" <Leader>e toggles vimfiler
nnoremap <silent> <Leader>e :VimFilerExplorer -auto-cd -toggle -winwidth=30 -parent<CR>
" }}}

" Unite {{{
let g:unite_source_history_yank_enable = 1  " Enable yank history in unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])  " Fuzzy matching
call unite#filters#sorter_default#use(['sorter_rank'])  " Sort unite results
" Unite settings
call unite#custom#profile('default', 'context', {
		\'auto_resize': 1,
		\'direction': 'botright',
		\'smartcase': 1,
		\'start_insert': 1,
		\'prompt': '>>> ',
		\'winheight': 10
		\})
" Unite-outline settings
call unite#custom#profile('source/outline', 'context', {
			\'auto_resize': 0,
			\'no_quit': 1,
			\'prompt_direction': 'top',
			\'start_insert': 0,
			\'vertical': 1,
			\'winwidth': 40
			\})

" <Leader>f opens unite
nnoremap <Leader>f :Unite buffer file_mru file/async file_rec/async<CR>
" <Leader>y opens unite yankring
nnoremap <Leader>y :Unite history/yank<CR>
" <Leader>o opens unite outline
nnoremap <Leader>o :Unite outline<CR>
" }}}

" Autocomplete/Snippets {{{
" Global settings {{{
let g:neocomplete#enable_at_startup = 1  " Use neocomplete
let g:neocomplete#enable_smart_case = 1  " Use smart case in neocomplete
let g:neocomplete#max_list = 30  " Only show 30 suggestions
call neocomplete#custom#source('ultisnips', 'rank', 1000)  " Rank snippets higher

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
" <Tab> cycles through completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <CR> inserts completion
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"

let g:UltiSnipsExpandTrigger = "<C-j>"  " <C-j> expands snippet
let g:UltiSnipsJumpForwardTrigger = "<C-j>"  " <C-j> jumps forwards in snippet
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"  " <C-k> jumps backwards in snippet
" }}}
" }}}

" Syntastic {{{
let g:syntastic_check_on_open = 1  " Check for errors when opening file
let g:syntastic_aggregate_errors = 1  " Combine errors from multiple linters
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
