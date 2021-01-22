let g:vimtex_delim_toggle_mod_list = [
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \]


let g:vimtex_quickfix_mode=1
set foldmethod=manual
let g:vimtex_fold_manual=1

" let g:vimtex_view_method='skim'

let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'jobs', 
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 0,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-pdf',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}

let g:vimtex_imaps_leader=';'
let g:vimtex_indent_ignored_envs = ['document', 'proof']

let g:vimtex_view_general_viewer = '/usr/local/bin/displayline'
"'/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_method='skim'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_view_general_options_latexmk = '-r'
if has('win32')
	let g:vimtex_view_general_viewer = 'SumatraPDF'
	let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
	let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif 
" let g:tex_flavor='latex'



"syntax on 
