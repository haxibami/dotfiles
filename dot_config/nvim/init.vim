"" neovim config

"" dein.vim setup

if &compatible
  set nocompatible
endif
filetype off
"" append to runtime path
set rtp+=~/.cache/dein/repos/github.com/Shougo/dein.vim
"" initialize dein, plugins are installed to this directory
call dein#begin(expand('~/.cache/dein'))
"" add packages here, e.g:
call dein#add('Shougo/dein.vim')
"" or install packages from toml file
let s:toml_dir  = $HOME . '/.config/nvim' 
let s:toml      = s:toml_dir . '/dein.toml'
let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
"" exit dein
call dein#end()
"" auto-install missing packages on startup
if dein#check_install()
  call dein#install()
endif

"" source files
if filereadable(expand('$HOME/.secure/dein_update.vim'))
    source $HOME/.secure/dein_update.vim
 endif

command! DeinUpdate call dein#check_update(v:true)

filetype plugin indent on

""display
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax enable
colorscheme urara
set ambiwidth=double
set wildmenu
set hidden
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=number
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
set pumblend=10
set list lcs=tab:\|\ 

"" enable clipboard integration
set clipboard&
set clipboard^=unnamedplus

"" search
set ignorecase
set smartcase
set wrapscan
set hlsearch

"" gui config
set guifont=PlemolJP\ Console:h22,HackgenNerd\ Console:h22

"" nvui config
if exists('g:nvui')
  NvuiCmdFontFamily PlemolJP Console
  NvuiCmdFontSize 30.0
  NvuiCmdPadding 5
  NvuiScrollAnimationDuration 0.2
  NvuiCmdCenterYPos 0.5
endif

""" Custom Functions

"" JpToggle settings
let g:jpmode = 0

nnoremap <M-q> :call Jptoggle(jpmode)<cr><Esc>
inoremap <M-q> <Esc>:call Jptoggle(jpmode)<cr><a><a>

function! Jptoggle(jpmode)
  if g:jpmode == 0
    nnoremap j gj
    nnoremap k gk
    nnoremap <Home> g0
    nnoremap <End> g$
    nnoremap <Down> gj
    nnoremap <Up> gk
    let g:jpmode = 1
    return g:jpmode
  else 
    nnoremap j j
    nnoremap k k
    nnoremap <Home> <Home>
    nnoremap <End> <End>
    nnoremap <Down> <Down>
    nnoremap <Up> <Up>
    let g:jpmode = 0
    return g:jpmode
  endif
endfunction

"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  ignore_install = { "phpdoc" },
"  highlight = {
"    enable = true,
"    disable = {
"      --'lua',
"      --'ruby',
"      --'toml',
"      --'c_sharp',
"      --'vue',
"    }
"  },
"  ensure_installed = 'maintained',
"}
"EOF
