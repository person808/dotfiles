" Plugins {{{
call plug#begin('~/.vim/plugged')
" Gui plugins
Plug 'w0ng/vim-hybrid'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
" Add features
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/bufkill.vim'
Plug 'scrooloose/NERDTree'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
" Editing
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
Plug 'majkinetor/unite-cmdmatch'

" Python
Plug 'tell-k/vim-autopep8', {'for': 'python'}
" Fish
Plug 'dag/vim-fish'
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
set updatetime=1000  " Lower updatetime for faster git gutter updates
set autochdir  " Automatically change directory to the one of the current file
let g:plug_threads = 30  " Update more plugins at once
" }}}

" User Interface {{{
set t_Co=256  " Use 256 terminal colors
colorscheme hybrid  " Set terminal colorscheme
" Show line numbers in current window
set number
autocmd WinEnter * setlocal number
autocmd WinLeave * setlocal nonumber
set cursorline  " Highlight line the cursor is on
set showmatch  " Show matching parentheses
set laststatus=2  " Always show status
set showtabline=2  " Always show tab bar
set showcmd  " Show information about current command
set scrolloff=5  " Always show 5 lines below cursor
set wrap  " Enable line wrapping
set linebreak  " Don't wrap lines on words

" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1  " Show the tabline
let g:airline#extensions#tabline#fnamemod = ':t'  " Only show filename in tabline
let g:airline_section_c = '%{getcwd()}'  " Replace path to file with current directory
let g:airline_powerline_fonts = 1  " Use powerline symbols
let g:airline_theme= 'zenburn'  " vim-airline theme
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
let g:indentLine_color_term = 236  " Set indent guide color
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
" :w! saves files using sudo
cnoremap w! w !sudo tee > /dev/null %
" <Leader>c comments line
nnoremap <Leader>c :Commentary<CR>
vnoremap <Leader>c :Commentary<CR>
" }}}

" Buffers/Tabs/Splits {{{
set hidden  " Hide buffers instead of closing them
" Open a new empty buffer
nnoremap <Leader>b :enew<CR>
" Move to the next buffer
nnoremap <Leader>l :bnext<CR>
" Move to the previous buffer
nnoremap <Leader>h :bprevious<CR>
" Delete buffer
nnoremap <Leader>bd :bdelete<CR>
" Close buffer and preserve window layout
cnoremap bc BD
nnoremap <Leader>bc :BD<CR>

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

" NERDTree {{{
autocmd vimenter * execute 'NERDTree' | wincmd p  " Start NERDTree with vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  " Automatically close vim if NERDTree is the only buffer
" <Leader>e toggles NERDTree
nnoremap <Leader>e :NERDTreeToggle<CR>
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
" <C-p> opens unite
nnoremap <C-p> :Unite buffer file_mru file/async file_rec/async<CR>
" <C-p><C-y> opens unite yankring
nnoremap <C-p><C-y> :Unite history/yank<CR>
" <C-p><C-o> opens unite outline
nnoremap <C-p><C-o> :Unite outline<CR>
" <TAB> opens unite cmdmatch in command mode
cmap <Tab> <Plug>(unite_cmdmatch_complete)
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
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
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

" .vimrc Settings {{{
autocmd BufWritePost .vimrc source %  " Automatically source .vimrc
" Fold .vimrc by marker
set modelines=2
" vim:foldmethod=marker:foldlevel=0
" }}}
