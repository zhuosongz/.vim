"设置latex suite 
"
set shellslash
" colorscheme sourthernlights
set winaltkeys=no
set wrap
set selection=inclusive
behave xterm
if !has('nvim')
	set macmeta
endif
set spell
set textwidth=80
set guifont=Monaco:h18
set conceallevel=0
set foldmethod=manual                 " could be marker...

let g:vimtex_fold_enabled=1           " 0 for disable
let g:vimtex_fold_types={
	\ 'markers' : {'enabled' : 1},
	\}
let b:current_syntax=''
" let g:vimtex_compiler_progname = 'nvr'

set updatetime=500                    " set refresh time
autocmd CursorHold *.tex silent write " auto save


" let g:neocomplete#sources#omni#input_patterns.tex =
"       \ '\s*$[^$]\{-}\$[.,\s]'
setlocal spell
set spelllang=en_us
" auto check spelling 
inoremap <A-l> <c-g>u<Esc>[s1z=`]a<c-g>u


function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>

function! IsMath()
  let current_syntax_id_attr = synIDattr(synID(line("."), col("."), 1), "name")
  return stridx(current_syntax_id_attr, "Math") >= 0
  " your_string contains "Math"
endfunction




autocmd InsertEnter * if IsMath() | setlocal iminsert=0 | endif
