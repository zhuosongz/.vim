function! AddOne()
    let prenew = input("Input the prefix: ")
    let numb = input("Input the number: ")
    let l:mystr = l:prenew . '\zs\d\+\ze'
    let l:valn = l:numb
    for l:line in range(1,line("$"))
        call setline(l:line, substitute(getline(l:line), l:mystr , '\=printf("%02d", ChoosePlusOneOrNot(submatch(0),' . l:valn . '))', "gc"  ))
    endfor 
endfunction

function! ChoosePlusOneOrNot(number, value)
    if a:number > a:value
        return a:number + 1
    else 
        return a:number
    endif 
endfunction



" Tex_Mathbb: 
function! Tex_Mathbb()
    return "\<Left>\\mathbb{\<Right>}"
endfunction
imap <A-x> <C-r>=Tex_Mathbb()<CR>


" Tex_MathHat: encloses the previous letter in \hat{} {{{
function! Tex_MathHat()
    return "\<Left>\\hat{\<Right>}"
endfunction 
" }}}

" Tex_MathBar: encloses the previous letter in \bar{} {{{
function! Tex_MathBar()
    return "\<Left>\\bar{\<Right>}"
endfunction 
" }}}

" Tex_MathTilde: encloses the previous letter in \tilde{} {{{
function! Tex_MathTilde()
    return "\<Left>\\tilde{\<Right>}"
endfunction 
" }}}


" Tex_MathBF: encloses te previous letter/number in \mathbf{} {{{
" Description: 
function! Tex_MathBF()
	return "\<Left>\\mathbf{\<Right>}"
endfunction " }}}
" Tex_MathCal: enclose the previous letter/number in \mathcal {{{
" Description:
" 	if the last character is not a letter/number, then insert \cite{}
function! Tex_MathCal()
	return "\<Left>\\mathcal{\<Right>}"
endfunction


function! InsertMiddleVert()
	let [l:open, l:close] = vimtex#delim#get_surrounding('delim_all')
	if empty(l:open) | return | endif 

	let l:midfull = matchstr(open.match,'\\\w\+')
	let l:mid = strpart(l:midfull,0,len(l:midfull)-1)
	return empty(l:mid) ? '\vert' : l:mid . 'm\vert'
endfunction 

imap <A-m> <c-r>=InsertMiddleVert()<cr>

function! ToggleEqWithLabels()
	" find the surrounding to detect whether it is starred or not
	let [l:open, l:close] = vimtex#delim#get_surrounding('env_tex')
	if empty(l:open) | return | endif 

	" If starred, do tse and add a label with prefix 'eq:'
	if l:open.starred
		normal mq
		normal tse
		normal ]MO
		let tewl_base_indent = indent(line('.') + 1)
		let tewl_eq_label = input("Input the equation label: ")
		let tewl_label_line = repeat(' ', tewl_base_indent + &shiftwidth) . '\label{' . tewl_eq_label . '}'
		call setline('.', tewl_label_line)
		execute "normal cseequ\<CR>"
		execute "normal `q"
	" If not starred, comment the label line and do tse
	else
		normal mq
		normal tse
		execute "normal :" . l:open.lnum . "," . l:close.lnum . "s\/\\\\label\/% \\\\label\/g\<CR>"
		normal `q
	endif
endfunction

