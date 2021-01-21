imap <F2> <ESC>:w<CR>:!R -e "rmarkdown::render('%')" && open %:t:r.html<CR><CR>
nmap <F2> <ESC>:w<CR>:!R -e "rmarkdown::render('%')" && open %:t:r.html<CR><CR>
" imap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>
" nmap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>
imap <F3> <ESC>:w<CR>:!R -e "rmarkdown::render('%','all')" && open %:t:r.pdf<CR><CR>
nmap <F3> <ESC>:w<CR>:!R -e "rmarkdown::render('%','all')" && open %:t:r.pdf<CR><CR>
