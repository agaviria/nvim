" plugins

call plug#begin('~/.local/share/nvim/plugged')

"" color

Plug 'cocopon/iceberg.vim'

"" misc

Plug 'Chiel92/vim-autoformat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'pbrisbin/vim-mkdir'
Plug 'plasticboy/vim-markdown'
Plug 'raviqqe/vim-non-blank'
Plug 'raviqqe/vim-pastplace'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/vim-auto-save'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'majutsushi/tagbar'

"" fuzzy finder

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"" Python

Plug 'alfredodeza/pytest.vim'
Plug 'zchee/deoplete-jedi'

"" Go

Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go'

"" Rust

Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang-nursery/rustfmt'
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'

"" Elm
Plug 'elmcast/elm-vim'
Plug 'pbogut/deoplete-elm'

"" Js && Jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

"" deoplete

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

"" operators

Plug 'kana/vim-operator-user'
Plug 'emonkak/vim-operator-sort'

"" text objects

Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'thinca/vim-textobj-comment'
Plug 'junegunn/vim-easy-align'

call plug#end()

" pure vim

augroup Rc
	autocmd!
augroup END

set autoread
set ttyfast
set nolazyredraw
set nobackup
set nowritebackup
set swapfile
set visualbell
set tildeop
set wildmenu
set wildmode=full
filetype plugin indent on
autocmd Rc BufWinEnter * set mouse=

"" tab setting

set autoindent
set expandtab
set smartindent
set shiftround
set smarttab
set shiftwidth=2
set tabstop=2
set list

autocmd Filetype elm setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

"" appearance

syntax on
set number
set relativenumber
set colorcolumn=80
set clipboard=unnamed
set showmatch
set showmode
set showcmd
set wrap
set inccommand=nosplit
set incsearch
set hlsearch
set splitbelow
set splitright
set cursorline
set backspace=indent,eol,start
set completeopt=menu
autocmd Rc BufRead,BufNewFile *.jl set filetype=julia
autocmd Rc BufRead,BufNewFile *.tisp set filetype=tisp
autocmd Rc BufRead,BufNewFile *.ts set filetype=typescript
autocmd Rc BufRead,BufNewFile *.aiml set filetype=text
autocmd Rc BufRead,BufNewFile *.rules set filetype=text
autocmd Rc FileType sh set filetype=zsh

"" keymaps

let g:mapleader = ","
let maplocalleader = '\\'

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
vnoremap . :normal .<CR>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap gj j
nnoremap gk k
nnoremap <esc><esc> :nohlsearch<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>ww :wq<cr>
nnoremap <leader>q :q<cr>
nnoremap Q :q!<cr>
nnoremap Y y$

" open and edit init.vim
nnoremap <leader>te :tabe ~/.config/nvim/init.vim<CR>>
nnoremap <leader>es :source ~/.config/nvim/init.vim<CR>

inoremap jj <Esc>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

cnoremap <c-h> <left>
cnoremap <c-j> <c-n>
cnoremap <c-k> <c-p>
cnoremap <c-l> <right>

" clipboard
if has('clipboard')
	if has('unnamedplus')  " When possible use + register for copy-paste
		set clipboard=unnamed,unnamedplus
	else         " On mac and Windows, use * register for copy-paste
		set clipboard=unnamed
	endif
endif

" Allow to copy/paste between VIM instances
"copy the current visual selection to ~/.vbuf
vmap <leader>y :w! ~/.vbuf<cr>
"copy the current line to the buffer file if no visual selection
nmap <leader>y :.w! ~/.vbuf<cr>
"paste the contents of the buffer file
nmap <leader>p :r ~/.vbuf<cr>
" Make sure that CTRL-A (used by gnu screen) is redefined
noremap <leader>inc <C-A>

" Useful mapping for managing tabs
nnoremap <leader>k :tabnext<CR>
nnoremap <leader>j :tabprevious<CR>

" Spelling check for NeoVim
nmap <leader>S <ESC>:setlocal spell spelllang=en_us<CR>


" plugin settings

"" deoplete

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


"" deoplete-rust

let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME . '/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src'


"" neosnippet

let g:neosnippet#enable_auto_clear_markers = 0
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = [
			\ '~/.config/nvim/snippets',
			\ '~/.config/nvim/plugged/vim-snippets/snippets']
imap <c-s> <plug>(neosnippet_expand_or_jump)
smap <c-s> <plug>(neosnippet_expand_or_jump)
xmap <c-s> <plug>(neosnippet_expand_target)

"" tagbar

set tags=tags,.git/tags
nnoremap <leader>tb :TagbarToggle<cr>
let g:rust_recommended_style = 0

let g:tagbar_type_rust = {
			\ 'ctagstype' : 'rust',
			\ 'kinds' : [
			\'T:types,type definitions',
			\'f:functions,function definitions',
			\'g:enum,enumeration names',
			\'s:structure names',
			\'m:modules,module names',
			\'c:consts,static constants',
			\'t:traits,traits',
			\'i:impls,trait implementations',
			\]
			\}

"" easymotion

nmap <leader>s <plug>(easymotion-s)
nmap <leader>/ <plug>(easymotion-sn)

"" easyalign

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" sneak

nmap t <plug>Sneak_s
nmap T <plug>Sneak_S
xmap t <plug>Sneak_s
xmap T <plug>Sneak_S
omap t <plug>Sneak_s
omap T <plug>Sneak_S

let g:sneak#s_next = 1


"" auto-pairs

let g:AutoPairsFlyMode = 0 " 0 enables AutoPair by default at startup
let g:AutoPairsShortcutBackInsert = '<M-b>'

"" elm-vim

let g:elm_format_autosave = 1


"" markdown

let g:vim_markdown_folding_disabled = 1


"" quickrun

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config.clojure = {'command' : 'clojure'}


"" fzf

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :History:<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>h :Helptags<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>m :Maps<cr>
nnoremap <leader>r :Ag<cr>
nnoremap <leader>u :History<cr>


"" autoformat

autocmd Rc BufEnter,BufWinEnter,BufRead,BufNewFile *
			\ if &filetype == "" | set filetype=text | endif
autocmd Rc BufWrite * :Autoformat
autocmd Rc FileType
			\ conf,cucumber,diff,elm,gitrebase,groovy,markdown,sh,text,tisp,xdefaults,yaml,zsh
			\ let b:autoformat_autoindent = 0
let g:formatters_python = ['autopep8']
let g:formatters_javascript = ['standard_javascript']
let g:rustfmt_autosave=1


"" ale

let g:ale_linters = {
			\ 'javascript' : ['standard'],
			\ 'python': ['flake8', 'pylint'],
			\ }
let g:ale_javascript_standard_options = '--global describe --global it'

"" Jsx syntax higlighting and indenting in .js
let g:jsx_ext_required = 0

"" auto-save

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1


"" lightline

let g:lightline = { 'colorscheme': 'seoul256' }


"" colorscheme

colorscheme iceberg

highlight normal      ctermbg=none
highlight nontext     ctermbg=none
highlight endofbuffer ctermbg=none
highlight vertsplit   cterm=none ctermfg=240 ctermbg=240
highlight visual      cterm=bold ctermbg=Blue   ctermfg=none guifg=#000000 guibg=LightBlue
highlight MatchParen  cterm=none ctermbg=214  ctermfg=15 gui=none guibg=#F4C713 guifg=#BA2525
