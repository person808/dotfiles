" Plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !wget -nc -q github.com/junegunn/vim-plug/raw/master/plug.vim -P ~/.vim/autoload/
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" Gui plugins
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar'
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
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
" Editing
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
" Autocomplete
Plug 'Raimondi/delimitMate'
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

" Misc settings {{{
set shell=bash
set updatetime=200
set timeoutlen=1000 ttimeoutlen=100
set history=1000
set backspace=indent,eol,start
set clipboard=unnamedplus
set lazyredraw
set ttyfast
set mouse=a
set ttymouse=xterm2
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
nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)
nnoremap Q :Autoformat<CR><CR>
" }}}

" Text display {{{
set number
set cursorline
set showmatch
" Highlight past 80th column
execute "set colorcolumn=" . join(range(81,335), ',')
set spell
set breakindent
set linebreak
set wrap
set virtualedit=onemore
set t_Co=256
colorscheme hybrid

let g:hybrid_use_Xresources = 1
" }}}

" Searching/Moving around {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set scrolloff=5

let g:incsearch#auto_nohlsearch = 1
let g:incsearch#consistent_n_direction = 1

" Automatically change directory to the file's directory (set autochdir is
" incompatible with vimfiler)
augroup change_dir
  autocmd BufEnter * silent! lcd %:p:h
augroup END

" Opens files at the last known cursor position
augroup open_last_line
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

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

" Buffers/Tabs/Splits {{{
set hidden
set splitbelow
set splitright
set laststatus=2
set showtabline=2

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%{getcwd()}'

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

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za
" }}}

" Indentation {{{
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set copyindent
set smarttab

let g:indentLine_char = '┊'
let g:indentLine_color_term = 102
" }}}

" Backup/Undo {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set undolevels=10000
set undofile
set undodir=$HOME/.vim/undo
" }}}

" Command line {{{
set showcmd
set wildmenu
set noshowmode
set shortmess+=c
set confirm
" }}}

" Tags {{{
set tags+=~/.vim/tags/*
let g:easytags_file = '~/.vim/tags/tags'
let g:easytags_by_filetype = '~/.vim/tags/'
let g:easytags_updatetime_min = 500
let g:easytags_async = 1
let g:easytags_resolver_links = 1
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_map_togglefold = "<Space>"

nnoremap <Leader>t :TagbarOpenAutoClose<CR>
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

" Misc plugins {{{
let g:plug_threads = 40
let g:gundo_preview_bottom = 1
" }}}

" DelimitMate {{{
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_balance_matchpairs = 1
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

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <Leader>f :Unite buffer file_mru file/async file_rec/async<CR>
nnoremap <Leader>y :Unite history/yank<CR>
nnoremap <Leader>g :Unite grep<CR>
" }}}


" Autocomplete/Snippets {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 30
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#enable_camel_case = 1
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
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

" <CR> expands snippets and inserts completions
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction


" <Tab> cycles completes common string and cycles through completions
inoremap <expr><TAB>
      \ neocomplete#complete_common_string() != '' ?
      \   neocomplete#complete_common_string() :
      \ pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
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
