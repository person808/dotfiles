" Plugins {{{
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
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/syntastic'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-fugitive'
" Utility
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
" Editing
Plug 'junegunn/vim-easy-align'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
" Autocomplete
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/UltiSnips'
" Unite
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-help'
" Notes
Plug 'dhruvasagar/vim-table-mode'
Plug 'fmoralesc/vim-pad'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Python
Plug 'davidhalter/jedi-vim'
" Fish
Plug 'dag/vim-fish'
call plug#end()
" }}}

" Misc settings {{{
set shell=/usr/bin/bash
set updatetime=500
set timeoutlen=1000 ttimeoutlen=100
set history=1000
set backspace=indent,eol,start
set clipboard=unnamedplus
set lazyredraw
set ttyfast
set mouse=a
set ttymouse=xterm2
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.cache/**
" }}}

" Misc Keybindings  {{{
" Built-in functions
let mapleader=","
let maplocalleader=",,"
inoremap jj <Esc>
nnoremap Y y$
nnoremap ; :
" sp opens spelling corrections
nnoremap sp a<C-x><C-s><C-p>

" Plugins
nnoremap <Leader>u :GundoToggle<CR>
nmap ga <Plug>(EasyAlign)
xmap <Enter> <Plug>(EasyAlign)
nnoremap Q :Autoformat<CR><CR>
" }}}

" Misc plugins {{{
let g:plug_threads = 40
let g:gundo_prefer_python3 = 1
let g:gundo_preview_bottom = 1
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
let g:seoul256_background = 234
colorscheme seoul256
" }}}

" Searching/Moving around {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set scrolloff=5

let g:incsearch#auto_nohlsearch = 1
let g:incsearch#magic = '\v'
let g:clever_f_smart_case = 1
let g:clever_f_show_prompt = 1

" Opens files at the last known cursor position
augroup open_last_line
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" k and j don't skip wrapped lines
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
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

let g:airline_theme = "zenburn"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = ""

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
set tags=./tags;~/.vim/tags/*;$HOME
let g:easytags_cmd = '/usr/bin/ctags --fields+=l'
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
nmap <silent> ghn <Plug>GitGutterNextHunk
      \ :call repeat#set("\<Plug>GitGutterNextHunk")<CR>
nmap <silent> ghp <Plug>GitGutterPreviousHunk
      \ :call repeat#set("\<Plug>GitGutterPreviousHunk")<CR>
nmap ghs <Plug>GitGutterStageHunk
nmap ghr <Plug>GitGutterRevertHunk
nmap ghv <Plug>GitGutterPreviewHunk
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
" }}}

" Notes {{{
let g:pad#dir = "~/Documents/notes/"
let g:pad#window_height = 15
let g:pad#open_in_split = 0
let g:pad#search_backend = "ag"
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#textwidth = 99
let g:pandoc#folding#fdc = 0
let g:pandoc#folding#level = 2
let g:pandoc#folding#mode = "relative"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#after#modules#enabled = ["ultisnips", "unite", "tablemode"]
let g:goyo_margin_top = 1
let g:goyo_margin_bottom = 1
" }}}

" Vimfiler {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_readonly_file_icon = ''
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
call vimfiler#custom#profile('default', 'context', {
      \ 'safe': 0
      \ })

nnoremap <silent> <Leader>e :VimFiler<CR>
nnoremap <silent> <Leader>es :VimFilerSplit<CR>
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
call unite#custom#source('file_rec/async', 'ignore_globs', split(&wildignore, ','))

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \ '.hg --ignore .svn --ignore .git --ignore .bzr --ignore .cache'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <Leader>f :Unite buffer file_mru file_rec/async<CR>
nnoremap <Leader>y :Unite history/yank<CR>
nnoremap <Leader>a :Unite grep<CR>
cabbrev h Unite help
" }}}

" Autocomplete/Snippets {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
call neocomplete#custom#source('ultisnips', 'rank', 1000)
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = 2
let g:jedi#force_py_version = 3
let g:jedi#popup_select_first = 0

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python =
      \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

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

" Allows jedi to complete python 3 modules. This can blow up and cause
" segfaults for some modules (ex. pyqt4)
python << EOF
import subprocess
other_python = 'python%d' % (22 if sys.version_info.major == 3 else 3,)
try:
    other_sys_path = subprocess.check_output(
    [other_python, '-c', 'import sys; print(sys.path)']).decode('utf-8')
except OSError:
    pass
else:
    other_sys_path = other_sys_path[2:-3].split("', '")
    sys.path += other_sys_path
EOF

" Keybindings {{{
" <Tab> cycles through completions
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent><expr><CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}
" }}}

" Syntastic {{{
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
