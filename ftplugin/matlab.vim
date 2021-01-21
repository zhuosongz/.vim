imap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>
nmap <F2> <ESC><ESC>:w<CR>:!matlab -nodesktop -nosplash -r %:r <CR>


" The matlab Connection
nnoremap <F5> <ESC><ESC>:w<CR>:call MatlabRun()<CR><CR>
nnoremap <S-F6> <ESC><ESC>:w<CR>:call RunMatlab()<CR><CR>
inoremap <F5> <ESC><ESC>:w<CR>:call MatlabRun()<CR><CR>
inoremap <S-F6> <ESC><ESC>:w<CR>:call RunMatlab()<CR><CR>

vnoremap <F6> <C-Q>0I% <ESC>


function! MatlabRun()
  execute "w"
  execute "!matlab-ctrl.py -U \"". expand("%:r") . "\""
endfunction

function! RunMatlab()
  execute "w"
  call system("matlab-launch.sh \"" . expand("%:r") . "\"")
endfunction

set guifont=Monaco:h18


set encoding=utf-8
" colo default " 可替换 Vim 自带的配色方案，也可以使用网上提供的配色

colorscheme material-monokai

syntax on
" set number " 显示行号

"autocmd vimenter * NERDTree

set macmeta

let c='a'
while c <= 'z'
  exec "set <M-".tolower(c).">=\e".c
  exec "imap \e".c." <M-".tolower(c).">"
  let c = nr2char(1+char2nr(c))
endw

let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<A-b>'
let g:AutoPairsShortcutToggle = '<A-p>'
let g:AutoPairsShortcutFastWrap = '<A-e>'
let g:AutoPairsShortcutJump = 'A-n'

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent


" let g:rainbow_active = 0
" " au FileType matlab,m call rainbow#load()
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

autocmd FileType matlab,m setlocal commentstring=%%s
" colorscheme solarized 
