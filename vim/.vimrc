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
" Editing
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
" Autocomplete
Plug 'Raimondi/delimitMate'
Plug 'Valloric/YouCompleteMe', {'do': './install.sh'}
Plug 'honza/vim-snippets'
Plug 'SirVer/UltiSnips'
" Ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'sgur/ctrlp-extensions.vim'
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
let g:plug_threads = 30  " Update more plugins at once
" }}}

" User Interface {{{
set t_Co=256  " Use 256 terminal colors
" let g:hybrid_use_Xresources = 1
colorscheme hybrid  " Set terminal colorscheme
set number  " Show line numbers
set cursorline  " Highlight line the cursor is on
set showmatch  " Show matching parentheses
set laststatus=2  " Always show status
set showtabline=2  " Always show tab bar
set showcmd  " Show information about current command
set wildmenu  " Show completions in command mode
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
set autoindent  " Always set autoindenting on
set copyindent  " Copy previous indentation when autoindenting
set smarttab  " Insert tabs on the start of a line using shiftwidth
set breakindent  " Make line wrapping respect indentation
let g:indentLine_char = '┊'  " Use Sublime Text style indent guides
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
let NERDTreeWinSize = 25  " Set NERDTree size
autocmd vimenter * execute 'NERDTree' | wincmd p  " Start NERDTree with vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  " Automatically close vim if NERDTree is the only buffer
" <Leader>e toggles NERDTree
nnoremap <Leader>e :NERDTreeToggle<CR>
" }}}

" ctrlp.vim {{{
let g:ctrlpmap = '<C-p>'  " Map ctrlp to <C-p>
let g:ctrlp_cmd = 'CtrlPMixed'  " <C-p> opens file, mru, and buffer searcher
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'  " Ignore some directories
let g:ctrlp_extensions = ['cmdline', 'funky', 'menu', 'yankring']  " Enable ctrlp extentions
let g:ctrlp_funky_syntax_highlight = 1  " Syntax highlighting in ctrlp-funky
" <C-p><C-f> opens CtrlPFunky
nnoremap <C-p><C-f> :CtrlPFunky<CR>
" <C-p><C-h> opens CtrlPCmdline history
nnoremap <C-p><C-h> :CtrlPCmdline<CR>
" <C-p><C-m> opens CtrlPMenu list of searchers
nnoremap <C-p><C-m> :CtrlPMenu<CR>
" <C-p><C-y> opens CtrlPYankring yank history
nnoremap <C-p><C-y> :CtrlPYankring<CR>
" }}}

" Autocomplete/Snippets {{{
let g:ycm_autoclose_preview_window_after_completion = 1  " Automatically close the preview window
" UltiSnips settings
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
let g:UltiSnipsJumpForwardTrigger = "<tab>"  " Jump backwards in snippets with <s-tab>
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"  " Jump backwards in snippets with <s-tab>
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
