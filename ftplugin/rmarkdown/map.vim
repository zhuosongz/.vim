inoremap <C-l> <C-x><C-l>
inoremap <C-o> <C-x><C-o>
inoremap <C-s> <C-x><C-s>

" ====================================================================================================
" Example: 
"   \begin{align*}
"       f(x) + g(x) = h(x).    
"       \label{ex-1}
"   \end{align*}
"
"   By lse, we comment the label part
"   By Lse, we remove the commant. 
" nmap lse tsevie:s/\(\\label\)/% \1/g<CR>
" nmap lsE cseequ<CR>[mo\label{}<Left>eq:
nmap <silent> lse :call ToggleEqWithLabels()<CR>

"nnoremap <A-o> V:s/\%\(\,\s*\)\@<!\([.,]\)\(\s*$\|\s*\\\\\)/\\,\1\2/<CR>
let @d = 'V:s/\%\(\,\s*\)\@<!\([.,]\)\(\s*$\|\s*\\\\\)/\\,\1\2/'
nnoremap <A-o> ma@d<CR>`a
inoremap <A-o> <ESC>ma@d<CR>`aa

inoremap <silent> <Plug>Tex_MathBF      <C-r>=Tex_MathBF()<CR>
inoremap <A-f> <C-r>=Tex_MathBF()<CR>
inoremap <A-6> <C-r>=Tex_MathHat()<CR>
inoremap <A--> <C-r>=Tex_MathBar()<CR>
inoremap <A-`> <C-r>=Tex_MathTilde()<CR>
inoremap <A-c> <C-r>=Tex_MathCal()<CR>

imap ]e <ESC>]M<ESC>o
imap ]d <ESC>lvad<ESC><ESC>a
imap ]s <ESC>va$<ESC><ESC>a
imap ]\ <ESC>A\\ <ESC><ESC>
imap ]a <ESC>va}<ESC>/{<CR>a
imap ]c <ESC>ci}

nmap j gj
nmap k gk

imap <F1> <Nop>
