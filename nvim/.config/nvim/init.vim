" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" Gui plugins
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
" Add features
Plug 'benekastah/neomake'
Plug 'Chiel92/vim-autoformat'
Plug 'haya14busa/incsearch.vim'
Plug 'rhysd/clever-f.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-fugitive'
" Utility
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
" Language support
Plug 'kballard/vim-fish'
Plug 'sheerun/vim-polyglot'
" Editing
Plug 'Raimondi/delimitMate'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
" Autocomplete
Plug 'honza/vim-snippets'
Plug 'SirVer/UltiSnips'
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --clang-completer --omnisharp-completer --gocode-completer'}
call plug#end()
" }}}
" Misc settings {{{
set updatetime=500
set timeoutlen=1000 ttimeoutlen=100
set history=1000
set clipboard+=unnamedplus
set lazyredraw
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.cache/**,.config/**,.local/**,.gem/**,.m2/**
" }}}
" Misc Keybindings {{{
let mapleader="\<Space>"
inoremap fj <Esc>
nnoremap Y y$
nnoremap ; :
nnoremap sp a<C-x><C-s><C-p>
nnoremap <Leader>u :GundoToggle<CR>
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
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
colorscheme gruvbox
" }}}
" Searching/Moving around {{{
set ignorecase
set smartcase
set scrolloff=5

let g:incsearch#auto_nohlsearch = 1
let g:clever_f_smart_case = 1

" Opens files at the last known cursor position
augroup open_last_line
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

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

nnoremap <silent> <Leader>bn :bnew<CR>
nnoremap <silent> L :bnext<CR>
nnoremap <silent> H :bprevious<CR>
nnoremap <silent> <Leader>bd :bdelete<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <Leader>wc :close<CR>
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <Leader><Space> za
" }}}
" Indentation {{{
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set copyindent
set smarttab
" }}}
" Backup/Undo {{{
set backup
set backupdir=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
set undolevels=10000
set undofile
set undodir=$HOME/.config/nvim/undo
" }}}
" Command line {{{
set confirm
set noshowmode
set shortmess+=c
set showcmd
set wildmode=longest,full
" }}}
" Terminal {{{
tnoremap <Esc> <C-\><C-n>
tnoremap fj <C-\><C-n>
augroup terminal
  autocmd!
  autocmd TermOpen * setlocal nospell
  autocmd TermOpen * setlocal shell=fish
augroup END
" }}}
" Tags {{{
let g:easytags_cmd = '/usr/bin/ctags --fields+=l'
let g:easytags_by_filetype = '~/.config/nvim/tags/'
let g:easytags_updatetime_min = 500
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolver_links = 1
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
      \ 'winheight': 20
      \ })
call unite#custom#source('file_rec/neovim', 'ignore_globs', split(&wildignore, ','))
call unite#custom#source('outline', 'sorters', ['sorter_rank', 'sorter_reverse'])
call unite#custom#source('file_mru', 'ignore_pattern', '/usr/local/share/nvim/runtime/doc')

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \ '.hg --ignore .svn --ignore .git --ignore .bzr --ignore .cache'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <Leader>ff :Unite buffer file_mru file_rec/neovim<CR>
nnoremap <Leader>sy :Unite history/yank<CR>
nnoremap <Leader>/ :Unite grep<CR>
nnoremap <Leader>sl :Unite outline<CR>
" }}}
" Autocomplete/Snippets {{{
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
let g:ycm_allow_changing_updatetime = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers =  {
    \ 'c' : ['->', '.'],
    \ 'cpp,objcpp' : ['->', '.', '::'],
    \ 'erlang' : [':'],
    \ 'lua' : ['.', ':'],
    \ 'objc' : ['->', '.'],
    \ 'ocaml' : ['.', '#'],
    \ 'perl' : ['->'],
    \ 'php' : ['->', '::'],
    \ 'python': ['from ', 'import ', '.'],
    \ 'ruby' : ['.', '::'],
    \ 'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
    \ 'cs,java,javascript,d,perl6,scala,vb,elixir,go' : ['.']
    \ }

" <CR> expands snippets and inserts completions
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction

inoremap <silent><expr><CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}
" Neomake {{{
let g:neomake_error_sign = {
      \ 'text': '>>',
      \ 'texthl': 'ErrorMsg',
      \ }
let g:neomake_warning_sign = {
      \ 'text': '>>',
      \ 'texthl': 'WarningMsg',
      \ }

augroup Neomake
  autocmd!
  autocmd CursorHoldI * Neomake
  autocmd BufWritePost * Neomake
augroup END
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
