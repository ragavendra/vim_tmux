" autocmd works only on vim reboot
nnoremap <buffer> <leader>e gg<cr>

" vim lang custom keys
" N, V, S and Op
map <buffer> <leader>c ^i"<space><esc>:w<cr>

" insert mode
imap <buffer> <leader>c <esc><leader>co

" normal
nnoremap <buffer> <leader>uc ^xxx<space><esc>:w<cr>
nnoremap  <buffer> <leader>bc ^i/* */<esc>hhi<space>

" visual mode
vnoremap <buffer> <leader>c :s/^/" /<cr>:noh<cr>
