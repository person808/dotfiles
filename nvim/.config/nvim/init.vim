" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-rooter'
Plug 'bling/vim-bufferline'
Plug 'carlitux/deoplete-ternjs', {'for': 'javascript'}
Plug 'fs111/pydoc.vim', {'for': 'python'}
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kballard/vim-fish', {'for': 'fish'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhinz/vim-grepper', {'on': 'Grepper'}
Plug 'mhinz/vim-signify'
" Plug 'morhetz/gruvbox'
Plug 'ianks/gruvbox'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo', {'on': ['MundoShow', 'MundoHide', 'MundoToggle']}
Plug 'SirVer/UltiSnips'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'ternjs/tern_for_vim', {'do': 'npm install', 'for': 'javascript'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-jedi', {'for': 'python'}
call plug#end()
" }}}
" Misc settings {{{
set updatetime=500
set timeoutlen=1000 ttimeoutlen=100
set history=1000
set clipboard+=unnamedplus
set lazyredraw
set wildignore=*.o,*.obj,*~,*.pyc,*.png,*.svg,*.jpg
set wildignore+=.cache/**,.local/**,.gem/**,.m2/**,.gradle/**

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
nnoremap <Leader>fed :e <C-r>=resolve(expand($MYVIMRC))<CR><CR>
" }}}
" Misc plugins {{{
let g:plug_threads = 20
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1
let g:mundo_preview_bottom = 1
let g:mundo_width = 30
let g:mundo_verbose_graph = 0
let g:rooter_resolve_links = 1
nnoremap <Leader>u :MundoToggle<CR>
" }}}
" Text display {{{
set number
set cursorline
set showmatch
set breakindent
set linebreak
set wrap
set background=dark
set termguicolors
colorscheme gruvbox
" }}}
" Searching/Moving around {{{
set inccommand=nosplit
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

nnoremap <silent> <Leader>bn :bnew<CR>
nnoremap <silent> L :bnext<CR>
nnoremap <silent> H :bprevious<CR>
nnoremap <silent> <Leader>bd :bdelete<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <Leader>wd :close<CR>
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <Leader><Space> za
" }}}
" Indentation {{{
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
set noshowmode
set shortmess+=c
set showcmd
set wildmode=longest,full
" }}}
" Terminal {{{
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap fj <C-\><C-n>
nnoremap <Leader>' :terminal<CR>
augroup terminal
  autocmd!
  autocmd TermOpen * setlocal nospell
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
nnoremap <Leader>gl :Commits<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
" }}}
" Autocomplete/Snippets {{{
set completeopt-=previewe
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:echodoc_enable_at_startup = 1
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:ulti_expand_or_jump_res = 0

if !exists('g:deoplete#omni#functions')
  let g:deoplete#omni#functions = {}
endif

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#same_filetypes = {}
endif
let g:context_filetype#same_filetypes.html = 'xhtml,css,stylus,less'
let g:context_filetype#same_filetypes.css = 'scss'

" <CR> expands snippets and inserts completions
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return deoplete#mappings#close_popup()
  endif
endfunction

augroup Autocomplete
  autocmd!
  autocmd CompleteDone,InsertLeave * pclose
augroup END

inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr><CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}
" FZF {{{
let g:fzf_commits_log_options =
      \"--graph --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %C(white)%s%C(reset)
      \%C(yellow)%d%C(reset)'"

function! SmartFiles()
  silent execute "GitFiles"
  if v:shell_error
    silent execute "Files"
  endif
endfunction

command! SmartFiles call SmartFiles()

augroup FZF
  autocmd!
  autocmd FileType fzf tnoremap fj <C-c>
augroup END

nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>ff :SmartFiles<CR>
nnoremap <Leader>fr :History<CR>
nnoremap <Leader>is :Snippets<CR>
nnoremap <Leader>sj :BTags<CR>
nnoremap <Leader>sJ :Tags<CR>
" }}}
" Linting {{{
let g:ale_sign_warning = ">>"
highlight link ALEWarningSign Question
" }}}
" Statusline {{{
let g:airline_theme = "gruvbox"
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
      \'__': '-',
      \'n': 'N',
      \'i': 'I',
      \'R': 'R',
      \'c': 'C',
      \'v': 'V',
      \'V': 'V',
      \'': 'V',
      \'s': 'S',
      \'S': 'S',
      \'': 'S',
      \}
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
" }}}

set modelines=1  " Fold .vimrc by markers
" vim:foldmethod=marker:foldlevel=0
