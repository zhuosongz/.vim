" call  TexNewMathZone('Env','equ',1)
" call vimtex#syntax#core#new_region_math('equ')
" call vimtex#syntax#core#new_region_math('esplit')

match ErrorMsg '\%>500v.\+'

syn region texMathRegionEnv matchgroup=texDelim contains=@texClusterMath  start="\\\(be\|ben\|bes\|besn\|bs\|ba\|ban\|bg\|bgn\|bm\|bmn\){" end="}" 

syntax region texZone start="\\begin{Highlighting}" end="\\end{Highlighting}\|%stopzone\>"
syntax region texZone start="\\begin{rc}" end="\\end{rc}\|%stopzone\>"
syntax region texZone start="\\begin{markdown}" end="\\end{markdown}\|%stopzone\>"

let g:vimtex_syntax_custom_cmds = [
           \ {
           \   'name': 'equ',
           \   'math': v:true
           \ },
           \ {
           \   'name': 'python_code',
           \   'region': 'texPythonCodeZone',
           \   'nested': 'python',
           \ },
           \ {
           \   'name': 'code',
           \   'region': 'texCodeZone',
           \   'nested': {
           \     'python': 'language=python',
           \     'c': 'language=C',
           \     'rust': 'language=rust',
           \   },
           \ },
           \]

