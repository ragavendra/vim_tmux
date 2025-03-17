
" normal mode
nnoremap  <buffer> <leader>c ^a!--<esc>$i--<esc>:w<cr>
nnoremap <buffer> <leader>uc ^xxx<space><esc>:w<cr>

" insert mode
inoremap <buffer> <leader>c //<space>
" noremap! <buffer> <leader>c //<space> 
imap <buffer> <leader>p <esc><leader>p
imap <buffer> <leader>bc /*  */<left><left><left>
imap <buffer> <leader>i #include <
" smap \c :s/^/\/\//<cr>
" vmap \bc ^i/* */<esc>hhi<space>

" visual mode
vnoremap <buffer> <leader>c :s/^/\/\//<cr>:noh<cr>
" vmap \uc :s/^\/\//<cr>
vnoremap <buffer> <leader>uc :s/\/\/[?<space>?<tab>]/<cr>
" '<,'>s/^/\/*/g - block comment
