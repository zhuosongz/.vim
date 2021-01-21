nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>


imap <F2> <ESC><ESC>:w<CR>:!python3 %<CR>
nmap <F2> <ESC><ESC>:w<CR>:!python3 %<CR>


set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent

set guifont=Monaco:h18


set encoding=utf-8
" colo default " 可替换 Vim 自带的配色方案，也可以使用网上提供的配色

colorscheme material-monokai

syntax on
" set number " 显示行号

" autocmd vimenter * NERDTree

set macmeta

let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "imap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw

" let g:AutoPairsFlyMode = 1
" let g:AutoPairsShortcutBackInsert = '<A-b>'
" let g:AutoPairsShortcutToggle = '<A-p>'
" let g:AutoPairsShortcutFastWrap = '<A-e>'
" let g:AutoPairsShortcutJump = 'A-n'

