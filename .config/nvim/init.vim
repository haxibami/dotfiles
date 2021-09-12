"neovim config

"dein.vim setup
if &compatible
  set nocompatible
endif
filetype off
" append to runtime path
set rtp+=/usr/share/vim/vimfiles
" initialize dein, plugins are installed to this directory
call dein#begin(expand('~/.cache/dein'))
" add packages here, e.g:
"call dein#add('/usr/share/vim/vimfiles')
"call dein#add('qwelyt/TrippingRobot')
" install packages from toml file
let s:toml_dir  = $HOME . '/.config/nvim' 
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
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"overall
set termguicolors
colorscheme dracula
syntax enable
set ambiwidth=double
set wildmenu
set hidden
set nobackup
set nowritebackup

set updatetime=300
set shortmess+=c
set signcolumn=number
set clipboard&
set clipboard^=unnamedplus

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


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
set pumblend=10
set shortmess-=S

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <C-E> :Fern . -reveal=% -drawer -toggle -width=40<CR>

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

"" git操作
nnoremap g[ :GitGutterPrevHunk<CR>
" g[で次の変更箇所へ移動する
nnoremap g] :GitGutterNextHunk<CR>
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250
" g]で前の変更箇所へ移動する

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

"ノーマルモードで
"スペース2回でCocList
nmap <silent> <space><space> :<C-u>CocList<cr>
"スペースhでHover
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
"スペースdfでDefinition
nmap <silent> <space>df <Plug>(coc-definition)
"スペースrfでReferences
nmap <silent> <space>rf <Plug>(coc-references)
"スペースrnでRename
nmap <silent> <space>rn <Plug>(coc-rename)
"スペースfmtでFormat
nmap <silent> <space>fmt <Plug>(coc-format)
