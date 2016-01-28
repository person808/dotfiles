" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'Chiel92/vim-autoformat'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'flazz/vim-colorschemes'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/gv.vim', {'on': 'GV'}
Plug 'justinmk/vim-sneak'
Plug 'kballard/vim-fish', {'for': 'fish'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-grepper', {'on': 'Grepper'}
Plug 'mhinz/vim-signify'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/UltiSnips'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'sjl/gundo.vim', {'on': ['GundoHide', 'GundoShow', 'GundoToggle']}
Plug 'ternjs/tern_for_vim', {'do': 'npm install', 'for': 'javascript'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
call plug#end()
" }}}
" Misc settings {{{
set autochdir
set updatetime=500
set timeoutlen=1000 ttimeoutlen=100
set history=1000
set clipboard+=unnamedplus
set lazyredraw
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.cache/**,.local/**,.gem/**,.m2/**

augroup whitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e  " Strip trailing whitespace
augroup END
" }}}
" Misc Keybindings {{{
let mapleader="\<Space>"
inoremap fj <Esc>
nnoremap Y y$
nnoremap ; :
nnoremap <Leader>fed :e $MYVIMRC<CR>
" }}}
" Misc plugins {{{
let g:plug_threads = 40
let g:gundo_preview_bottom = 1
nnoremap <Leader>u :GundoToggle<CR>
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
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
colorscheme gruvbox
" }}}
" Searching/Moving around {{{
set ignorecase
set smartcase
set scrolloff=5

let g:incsearch#auto_nohlsearch = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" Opens files at the last known cursor position
augroup open_last_line
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)
nnoremap <Leader>/ :Grepper<CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}
" Buffers/Tabs/Splits {{{
set hidden
set splitbelow
set splitright
set laststatus=2
set showtabline=2

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

xnoremap < <gv
xnoremap > >gv
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
let g:gutentags_cache_dir = "~/.config/nvim/tags/"
let g:gutentags_resolve_symlinks = 1
" }}}
" Git {{{
nmap <leader>gj <Plug>(signify-next-hunk)
nmap <leader>gk <Plug>(signify-prev-hunk)
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :GV<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
" }}}
" Autocomplete/Snippets {{{
let g:deoplete#enable_at_startup = 1
let g:echodoc_enable_at_startup = 1
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:ulti_expand_or_jump_res = 0

" <CR> expands snippets and inserts completions
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return deoplete#mappings#close_popup()
  endif
endfunction

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
  autocmd BufWritePost * Neomake
augroup END
" }}}
" Statusline {{{
let g:airline_theme = "zenburn"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = ""
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
