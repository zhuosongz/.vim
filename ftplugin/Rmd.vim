imap <F2> <ESC>:w<CR>:AsyncRunR -e "rmarkdown::render('%')" && open -a Skim %:t:r.pdf<CR><CR>
nmap <F2> <ESC>:w<CR>:!Rscript -e "rmarkdown::render('%', 'all')" && open -a Skim %:t:r.pdf<CR><CR>
" imap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>
" nmap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>
imap <F3> <ESC>:w<CR>:AsyncRun R -e "rmarkdown::render('%')" && open -a Skim %:t:r.pdf<CR><CR>
nmap <F3> <ESC>:w<CR>:AsyncRun R -e "rmarkdown::render('%', 'all')" && open -a Skim %:t:r.pdf<CR><CR>

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

