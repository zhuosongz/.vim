set shiftwidth=2


nmap <C-B> :w<CR>:!g++ % -o %:r -larmadillo && ./%:r<CR>
imap <C-B> <ESC>:w<CR>:!g++ % -o %:r -larmadillo && ./%:r<CR>
