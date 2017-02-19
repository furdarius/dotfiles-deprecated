set nocompatible

let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-commentary'

" Navigation
Plug 'ctrlpvim/ctrlp.vim'

Plug 'majutsushi/tagbar'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Ansible
Plug 'pearofducks/ansible-vim'

" Status line
Plug 'itchyny/lightline.vim'

Plug 'bronson/vim-trailing-whitespace'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'scrooloose/nerdtree'

Plug 'Raimondi/delimitMate'

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'corylanou/vim-present', {'for' : 'present'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'fatih/vim-hclfmt'
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}

Plug 'unblevable/quick-scope'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

call plug#end()

" Editor
set background=dark
colorscheme molokai
if !has('gui_running')
  set t_Co=256
endif

filetype plugin indent on      " Automatically detect file types.
syntax on                      " Syntax highlighting

"" Encoding
set nobomb
set ttyfast
if !has('nvim')
    set encoding=utf-8
endif
set fileencoding=utf-8
set fileencodings=utf-8
set completeopt=menu
set termencoding=utf8
scriptencoding utf-8
set noshowmode
set history=1000               " Store a ton of history (default is 20)
set autoread                   " Read changed files
set autowrite                  " Automatically write a file when leaving a modified buffer
set splitbelow
set splitright
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmenu            " visual autocomplete for command menu

set fileformats="unix,dos,mac"
set formatoptions+=1           " When wrapping paragraphs, don't end lines
                               "    with 1-letter words (looks stupid)

"" Copy/Paste/Cut
set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

"" Fix backspace indent
set backspace=indent,eol,start

" Do backups!
set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.cache/vimundo
set backupdir=$HOME/.cache/vimbackup
set directory=$HOME/.cache/vimswap
for dir in [&undodir, &backupdir, &directory]
    if !isdirectory(dir)
        call mkdir(dir)
    endif
endfor

set number                      " Show absolute numbers
set ignorecase                  " Case insensitive search
" set smartcase                   " Case sensitive when uc present
set hlsearch                    " Highlight search terms

" Formatting
set nowrap          " Do not wrap lines.
set autoindent      " Copy indent from last line when starting new line.
set smartindent     " Know about functions end while intending.
set textwidth=80   " lines longer than 79 columns will be broken

" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set lazyredraw          " redraw only when we need to.

set number
set numberwidth=5
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist
set laststatus=2
set showbreak=↪>\

" Plugin settings

let g:rehash256 = 1

" Ctrlp

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'  " jump to a file if it's open already
let g:ctrlp_mruf_max=450    " number of recently opened files
let g:ctrlp_max_files=0     " do not limit the number of searchable files
let g:ctrlp_map = '<c-p>'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("v")': ['<c-z>'],
    \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }


let g:ctrlp_match_window = 'bottom,order:btt,max:10,results:10'
let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ftv'}

nmap <C-b> :CtrlPCurWD<cr>
imap <C-b> <esc>:CtrlPCurWD<cr>

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s --hidden -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif


set termguicolors

" statusline config
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 0

if !has('nvim')
    let g:go_dispatch_enabled = 1
endif

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_structs = 1

let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "10s"

let g:go_disable_autoinstall = 1
let g:go_loaded_gosnippets = 1
let g:go_snippet_engine = "neosnippet"

" neosnippet
let g:neosnippet#enable_snipmate_compatibility = 0
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory =
    \$XDG_CONFIG_HOME.'/vim/snippets/rafi,'
    \.$XDG_CONFIG_HOME.'/vim/snippets/shougo/neosnippets,'
    \.$XDG_CONFIG_HOME.'/vim/bundle/go/gosnippets/snippets'

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'


" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Check python3 with :echo has("python3")
" Do for installing
" sudo python3 -m pip install --upgrade --force pip
" pip3 install neovim
let g:python_host_prog = '/usr/bin/python'
" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1
let g:python_host_skip_check = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
let g:deoplete#sources#go#gocode_binary = $GOPATH . '/bin/gocode'


imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null


augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf
augroup END


" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
        \ formatoptions+=croq softtabstop=4 smartindent
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

augroup FileType json
    autocmd!
    autocmd FileType json setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-doc)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

augroup yaml
    autocmd!
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

augroup vimrc-ruby
    autocmd!
    autocmd BufNewFile,BufRead *.rb,*.gemspec setlocal filetype=ruby
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

" Navigation

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

" make it easier to jump between errors in quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Center the screen
nnoremap <space> zz

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Search for the word under the cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" tab navigations
nmap <tab> gt
nmap <s-tab> gT

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<CR>

" Quickly close the current window
nnoremap <leader>Q :q<CR>
" Quickly close the current buffer
nnoremap <leader>q :bd<CR>
nnoremap <leader>w :w<CR>

noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
