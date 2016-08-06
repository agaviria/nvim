" Plugin {
    " Instalation {
        call plug#begin('~/.config/nvim/plugged')
    " }

    " Base Plugins
    "
    Plug 'scrooloose/NERDTree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

    " autocomplete
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'SirVer/ultisnips'

    " rust
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'rust-lang/rust', {'for': 'none'}
    Plug 'timonv/vim-cargo', { 'for': 'rust' }
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }
    Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

    " go
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }

    " fast file switcher - fuzzy finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " others
    Plug 'jiangmiao/auto-pairs'
    Plug 'majutsushi/tagbar'
    Plug 'rhysd/try-colorscheme.vim'

    call plug#end()
" }

" General {
"
    if &term =~ '256color'
      " disable Background Color Erase (BCE) so that color schemes
      " render properly when inside 256-color tmux and GNU screen.
      " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
      set t_ut=
    endif

    " auto-pairs
    let g:AutoPairsFlyMode = 0 " 0 enables Autopairs by default at startup
    let g:AutoPairsShortcutBackInsert = '<M-b>'

    " Ultisnips settings
    " If you want :UltiSnipsEdit to split your window.
    inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    let g:UltisnipsExpandTrigger='<tab>'
    let g:UltisnipsJumpForwardTrigger='<tab>'
    let g:UltisnipsJumpBackwardTrigger='<s-tab>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/plugged/ultisnips/UltiSnips']

    " Add mapping to make ctrl space go to next completion option
    " <Nul> is interpreted as ctrl-space
    inoremap <Nul> <C-n>

    " deoplete settings
    let g:deoplete#enable_at_startup = 1 " Use deoplete.
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#omni_patterns = {}

    " deoplete-rust settings
    let g:rustfmt_autosave = 1
    let g:deoplete#sources#rust#racer_binary='/Users/ag/.cargo/bin/racer'
    let g:deoplete#sources#rust#rust_source_path='/Users/ag/.config/nvim/plugged/rust/src'
    let g:deoplete#omni_patterns.rust = '[(\.)(::)]'
    let g:racer_cmd = '/Users/ag/.cargo/bin/racer'
    let g:cargo_command = '!cargo {cmd}'
    let $CARGO_HOME='/Users/ag/.cargo'
    " let $RUST_SRC_PATH='/Users/ag/.config/nvim/plugged/rust/src'

    " tagbar settings
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

    au FileType rust map <leader>cr :wa<CR> :CargoRun<CR>
    au FileType rust map <leader>cb :wa<CR> :CargoBuild<CR>
    au FileType rust map <leader>ct :wa<CR> :CargoTest<CR>

    " deoplete-go settings
    let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
    let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_interfaces = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:go_auto_type_info = 1

    au FileType go map <leader>gr <Plug>(go-run)
    au FileType go map <leader>gb <Plug>(go-build)
    au FileType go map <leader>gt <Plug>(go-test)
    au FileType go map <leader>gc <Plug>(go-coverage)

    filetype plugin indent on    " Automatically detect file types
    colorscheme solarized
    syntax on           " Syntax highlighting

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
" }

" UI {
    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        " this does not work yet, maybe we should remove it and have a simpler status line
        "if !exists('g:override_spf13_bundles')
        "    set statusline+=%fugitive#statusline() " Git Hotness
        "endif
        "set statusline+=\ [%&ff/%Y]            " Filetype
        "set statusline+=\ [%getcwd()]          " Current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    " Relative line numbers toggle
    autocmd InsertEnter * :set relativenumber!
    autocmd InsertLeave * :set relativenumber
    au FocusLost * :set relativenumber!
    au FocusGained * :set relativenumber
    au BufEnter * :set relativenumber
    au BufLeave * :set relativenumber!

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
"
    set wrap                        " wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:neovim_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:neovim_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
" }

" Functions {
"
    " Relative line number toggle key
    function! NumberToggle()
        if(&relativenumber == 1)
            set number
        else
            set relativenumber
        endif
    endfunction

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    function! VisualSelection(direction, extra_filter) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("Ag \"" . l:pattern . "\" " )
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction
    " }
" }

" Key mapping {
"
    " Note that Mac command key is not sent by the terminal, thus not available
    " fdsafds fdsafds f dsafds llfda 
    let mapleader=','
    let maplocalleader='\\'

    " open and edit init.vim
    nnoremap <leader>ev :tabe ~/.config/nvim/init.vim<cr>

    vnoremap < <gv " Visual shifting (does not exit Visual mode)
    vnoremap > >gv

    " Easier moving in tabs and windows
    "map <C-J> <C-W>j<C-W>_
    "map <C-K> <C-W>k<C-W>_
    "map <C-L> <C-W>l<C-W>_
    "map <C-H> <C-W>h<C-W>_
    "This is based on the golang setup, which might be better
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " when wrapped is on, go to virual line instead of line in file 
    noremap j gj
    noremap k gk

    " Yank from the cursor to the end of the line
    nnoremap Y y$

    " Display toggle tagbar ( conflicts with byobu tmux setup)  **FIX ME!!
    " nmap <F8> :TagbarToggle<CR>

    " disable search highlight
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>fw to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>fw [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Simply zl/zh to scroll horizontally
    map zl zL
    map zh zH

    " Easier formatting
    " Not sure how that works yet
    " nnoremap <silent> <leader>q gwip

    " FZF {
        " Fuzzy Open files
        nnoremap <silent> <leader>o :Files<CR>

        " Fuzzy open git files
        nnoremap <silent> <leader>g :GitFiles<CR>

        " Fuzzy open buffer
        nnoremap <silent> <leader>b :Buffers<CR>

        vnoremap <silent> gv :call VisualSelection('gv', '')<CR> 

    " }
    " NERDTree {

        " Locate file in hierarchy quickly
        map <leader>n :NERDTreeFind<cr>

        " Toggle on/off
        map <leader>nn : NERDTreeToggle<cr>

    " }

    " Switch be3tween the last two files
    nnoremap <leader><leader> <C-^>

    " write and quit
    nnoremap <leader>ww :wq<CR>
    nnoremap <leader>w :w<CR>
    nnoremap <leader>q :q<CR>
    nnoremap <leader>qq :q!<CR>

    " Allow to copy/paste between VIM instances
    "copy the current visual selection to ~/.vbuf
    vmap <leader>y :w! ~/.vbuf<cr>

    "copy the current line to the buffer file if no visual selection
    nmap <leader>y :.w! ~/.vbuf<cr>

    "paste the contents of the buffer file
    nmap <leader>p :r ~/.vbuf<cr>

    " Make sure that CTRL-A (used by gnu screen) is redefined
    noremap <leader>inc <C-A>

    " Fast saving
    map <Leader>w :w<CR>
    imap <Leader>w <ESC>:w<CR>
    vmap <Leader>w <ESC><ESC>:w<CR>

    " This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
    inoremap jj <esc>
    nnoremap JJJJ <nop>

    " Useful mappings for managing tabs (not sure if I like it) 
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove<cr>
    map <leader>tj :tabnext<cr>
    map <leader>tk :tabprevious<cr>

    " Let 'tl' toggle between this and the last accessed tab
    let g:lasttab = 1
    nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
    au TabLeave * let g:lasttab = tabpagenr()

    " Opens a new tab with the current buffer's path
    " Super useful when editing files in the same directory
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

    " Nice to have for Neovim
    set spell spelllang=en_us
" }

