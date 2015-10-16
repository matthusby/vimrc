call plug#begin('~/.vim/plugged')

" Base modules
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-scripts/buftabs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'bronson/vim-trailing-whitespace'
Plug 'eparreno/vim-l9' | Plug 'othree/vim-autocomplpop'
Plug 'flazz/vim-colorschemes'

" Php Plugs
Plug 'shawncplus/phpcomplete.vim'

" Javascript Plugs
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Elixir Plugs
Plug 'elixir-lang/vim-elixir'
Plug 'mattreduce/vim-mix'

call plug#end()

let mapleader = "\<Space>" 		" Map space as leader
set nocompatible 				" Lots of fancy stuff
set encoding=utf-8

"------  Visual Options  ------
syntax on		" Highlighting on
set number		" Line numbers
set nowrap		" Noped out of wrapping
set statusline=%<%f\ %h%m%r%=%{fugitive#statusline()}\ \ %-14.(%l,%c%V%)\ %P
let g:buftabs_only_basename=1
let g:buftabs_marker_modified = "+"

"------  Generic Behavior  ------
set list			" Show whitespace
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
set tabstop=4		" Tab shown as 4 spaces
set shiftwidth=4	" Indent 4 spaces
set hidden			" Hide buffers instead of closing them
filetype indent on
filetype plugin on
set autoindent
set noexpandtab		" Don't expand tabs to spaces
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,node_modules/*

"allow deletion of previously entered data in insert mode
set backspace=indent,eol,start

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Accidentally pressing Shift K will no longer open stupid man entry
noremap K <nop>

" Wtf is Ex Mode anyways?
nnoremap Q <nop>

"------  Text Navigation  ------
" Prevent cursor from moving to beginning of line when switching buffers
set nostartofline

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" H = Home, L = End
noremap H ^
noremap L $
vnoremap L g_

"------  Window Navigation  ------
" ,hljk = Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

"------  Buffer Navigation  ------
" Ctrl Left/h & Right/l cycle between buffers
noremap <silent> <C-left> :bprev<CR>
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-right> :bnext<CR>
noremap <silent> <C-l> :bnext<CR>

" ,q Closes the current buffer
nnoremap <silent> <Leader>q :Bclose<CR>

" ,Q Closes the current window
nnoremap <silent> <Leader>Q <C-w>c

"------  Searching  ------
set incsearch
set ignorecase
set smartcase
set hlsearch

" Clear search highlights when pressing ,b
nnoremap <silent> <leader>b :nohlsearch<CR>

" CtrlP will load from the CWD, makes it easier with all these nested repos
let g:ctrlp_working_path_mode = ''

"------  NERDTree Options  ------
let NERDTreeIgnore=['CVS','\.dSYM$']

"setting root dir in NT also sets VIM's cd
let NERDTreeChDirMode=2

" Toggle visibility using ,n
noremap <silent> <Leader>n :NERDTreeToggle<CR>

" These prevent accidentally loading files while focused on NERDTree
autocmd FileType nerdtree noremap <buffer> <c-left> <nop>
autocmd FileType nerdtree noremap <buffer> <c-h> <nop>
autocmd FileType nerdtree noremap <buffer> <c-right> <nop>
autocmd FileType nerdtree noremap <buffer> <c-l> <nop>

" Open NERDTree if we're executing vim without specifying a file to open
autocmd vimenter * if !argc() | NERDTree | endif

" Close if only NERDTree open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Hides "Press ? for help"
let NERDTreeMinimalUI=1

"------  Tagbar Plugin Options  ------
let g:tagbar_width=36
noremap <silent> <Leader>y :TagbarToggle<CR>

" ,ct = Builds ctags
map <Leader>ct :! /usr/local/bin/ctags -R *<CR>

"------  Fugitive Plugin Options  ------
"https://github.com/tpope/vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove
nnoremap <Leader>gp :Ggrep
nnoremap <Leader>gR :Gread<CR>
nnoremap <Leader>gg :Git
nnoremap <Leader>gd :Gdiff<CR>

"------  PHP Filetype Settings  ------
" ,p = Runs PHP lint checker on current file
map <Leader>p :! php -l %<CR>

au FileType php set omnifunc=phpcomplete#CompletePHP
let g:neocomplete#enable_at_startup = 1

"------  Elixir Filetype Settings  ------
au BufNewFile,BufReadPost *.ex,*.exs set shiftwidth=4 softtabstop=4 noexpandtab

colorscheme Tomorrow-Night

"------  GUI Options  ------
if has("gui_running")
        " Hides toolbar and scrollbars and File menu
        set guioptions=egt

        " Highlights the current line background
        set cursorline

        "Invisible character colors
        highlight NonText guifg=#4a4a59
        highlight SpecialKey guifg=#4a4a59

        if has("gui_macvim") " OS X
                set guifont=Monaco:h14
                "set noantialias
                set transparency=3

                " Swipe to move between bufers :D
                map <silent> <SwipeLeft> :bprev<CR>
                map <silent> <SwipeRight> :bnext<CR>

                " Cmd+Shift+N = new buffer
                map <silent> <D-N> :enew<CR>

                " Cmd+t = new tab
                nnoremap <silent> <D-t> :tabnew<CR>

                " Cmd+w = close tab (this should happen by default)
                nnoremap <silent> <D-w> :tabclose<CR>

                " Cmd+1...9 = go to that tab
                map <silent> <D-1> 1gt
                map <silent> <D-2> 2gt
                map <silent> <D-3> 3gt
                map <silent> <D-4> 4gt
                map <silent> <D-5> 5gt
                map <silent> <D-6> 6gt
                map <silent> <D-7> 7gt
                map <silent> <D-8> 8gt
                map <silent> <D-9> 9gt

                " OS X probably has ctags in a weird place
                let g:tagbar_ctags_bin='/usr/local/bin/ctags'

        elseif has("gui_gtk2") " Linux
                set guifont=monospace\ 9

                " Alt+n = new buffer
                map <silent> <A-n> :enew<CR>

                " Alt+t = new tab
                nnoremap <silent> <A-t> :tabnew<CR>

                " Alt+w = close tab
                nnoremap <silent> <A-w> :tabclose<CR>

                " Alt+1...9 = go to that tab
                map <silent> <A-1> 1gt
                map <silent> <A-2> 2gt
                map <silent> <A-3> 3gt
                map <silent> <A-4> 4gt
                map <silent> <A-5> 5gt
                map <silent> <A-6> 6gt
                map <silent> <A-7> 7gt
                map <silent> <A-8> 8gt
                map <silent> <A-9> 9gt
	endif
else
        set t_Co=256
        set mouse=a
endif

" Javascript
let g:jsx_ext_required = 0 " Turn on react highlighting for .js files
let g:jsx_pragma_required = 1
