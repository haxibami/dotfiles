" vim:fdm=marker:fmr=§§,■■

" §§1 SATySFi
augroup vimrc
  autocmd BufRead,BufNewFile *.saty setfiletype satysfi
  autocmd BufRead,BufNewFile *.satyg setfiletype satysfi
  autocmd BufRead,BufNewFile Satyristes setfiletype lisp
  autocmd BufRead,BufNewFile *.saty nnoremap <buffer> @o :!open %:r.pdf<CR>
  autocmd BufRead,BufNewFile *.saty nnoremap <buffer> @q :!satysfi %<CR>
  autocmd BufRead,BufNewFile *.saty nnoremap <buffer> @Q :!satysfi --debug-show-bbox --debug-show-space --debug-show-block-bbox --debug-show-block-space --debug-show-overfull %<CR>
augroup END
