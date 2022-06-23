" ddc config
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sources', [
      \  'nvim-lsp',
      \  'around',
      \  'file'
      \  ])
call ddc#custom#patch_global('sourceOptions', {
      \'_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy'],
      \ },
      \ 'nvim-lsp': {
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
      \ },
      \ 'around': {'mark': 'Around'},
      \ 'file': {
      \   'mark': 'file',
      \   'isVolatile': v:true, 
      \   'forceCompletionPattern': '\S/\S*'
      \ }
      \ })
" Use Customized labels
call ddc#custom#patch_global('sourceParams', {
      \ 'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
      \ })
call ddc#custom#patch_global('autoCompleteEvents', [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged',
      \ ])
call ddc#enable()

" key binding
inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

" remapping
nnoremap ;       <Cmd>call CmdlinePre(':')<CR>:
nnoremap /       <Cmd>call CmdlinePre('/')<CR>/
nnoremap ?       <Cmd>call CmdlinePre('?')<CR>?

function! CmdlinePre(mode) abort
  set wildchar=<C-t>
  set wildcharm=<C-t>
  cnoremap <expr><buffer> <Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ exists('b:ddc_cmdline_completion') ? ddc#manual_complete() : "\<C-t>"
  " Overwrite sources
  if !exists('b:prev_buffer_config')
      let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  call ddc#custom#patch_buffer('completionMenu', 'pum.vim')
  if a:mode ==# ":"
      call ddc#custom#patch_buffer('cmdlineSources', ['cmdline', 'cmdline-history', 'around'])
      call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
  else
      call ddc#custom#patch_buffer('cmdlineSources', ['around'])
  endif
  autocmd User DDCCmdlineLeave ++once call CmdlinePost()
  autocmd InsertEnter <buffer> ++once call CmdlinePost()

  call ddc#enable_cmdline_completion()
endfunction

function! CmdlinePost() abort
  silent! cunmap <buffer> <Tab>
  " Restore sources
  if exists('b:prev_buffer_config')
      call ddc#custom#set_buffer(b:prev_buffer_config)
      unlet b:prev_buffer_config
  else
      call ddc#custom#set_buffer({})
  endif
  set wildcharm=<Tab>
endfunction

