"vim config

"dein.vim setup
if &compatible
  set nocompatible
endif
filetype off
" append to runtime path
set rtp+=/usr/share/vim/vimfiles
" initialize dein, plugins are installed to this directory
call dein#begin('~/.cache/deinmin')
" add packages here, e.g:
"call dein#add('qwelyt/TrippingRobot')
" install packages from toml file
let s:toml_dir  = $HOME . '/.vim/userautoload/dein' 
let s:toml      = s:toml_dir . '/dein.toml'
let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
" exit dein
call dein#end()
" auto-install missing packages on startup
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"overall
set termguicolors
syntax enable
let g:dracula_colorterm=0
colorscheme dracula
set ambiwidth=double
set wildmenu
set hidden
set nobackup
set nowritebackup

set updatetime=300
set shortmess+=c
set signcolumn=number

"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder.
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end


"search
set ignorecase
set smartcase
set wrapscan
set hlsearch

"display
set title
set number
set showmatch matchtime=1
set cmdheight=2
set laststatus=2
set showcmd
set listchars=tab:^\ ,trail:~
set history=10000
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set showmatch
set shortmess-=S
