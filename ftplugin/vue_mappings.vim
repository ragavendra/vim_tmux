
" autocmd works only on vim reboot
nnoremap <buffer> <leader>e gg<cr>

" nnoremap <buffer> <leader>i gg0i#include <
nnoremap <buffer> <leader>i gg0o#include <
nnoremap <buffer> <leader>d i#define
nnoremap <buffer> <leader>c ^i//<space><esc>:w
map <buffer> <leader>p iprintf("
nnoremap <buffer> <leader>uc ^xxx<space><esc>:w
nnoremap  <buffer> <leader>bc ^i/* */<esc>hhi<space>

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
