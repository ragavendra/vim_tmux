" normal mode
nnoremap <buffer> <leader>r :w<cr>:!python3 %<cr>
map <buffer> <leader>p iprint(
nnoremap <buffer> <leader>c ^i#<space><esc>:w<cr>

" insert mode
imap <buffer> <leader>p <esc><leader>p
inoremap <buffer> <leader>c #<space>
