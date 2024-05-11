" vim: set fdm=marker:

imap <D-i> ```{r}<CR><CR>```<ESC>ki
nmap <D-i> i```{r}<CR><CR>```<ESC>ki

set conceallevel=0

setlocal spell
set spelllang=en_us
" auto check spelling 
imap <c-b> <c-g>u<Esc>[s1z=`]a<c-g>u

set softtabstop=2
" set shiftwidth=2
" set tabstop=2
" autocmd FileType markdown setlocal comments=n:>
" let g:vim_markdown_new_list_item_indent = 0

