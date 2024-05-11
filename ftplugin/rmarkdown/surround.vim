" ====================================================================================================
"
"
" ====================================================================================================
" What does this mean? 
"  f ( I ) --- by cs(U, we get ---> f \{ I \} 
"          --- by cs(u, we get ---> f \[ I \]
"
"   Package required: *surrounder*
"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"
let b:surround_{char2nr('C')} = "{\\\1command: \1 \r}"
let b:surround_85 = "\\{\r\\}" 
" 85 is ascii of U
let g:surround_86 = "\\lVert \r \\rVert" 
" 86 is ascii of V
let g:surround_118 = "\\lvert \r \\rvert" 
" 118 is ascii of v
let g:surround_117 = "\\[\r\\]"
" 117 is ascii of u
let g:surround_119 = "\\willignore{\r}" 
"" existing capability
""let g:surround_{char2nr("v")} = "‘\r’"
""let g:surround_{char2nr("V")} = "“\r”"

"" hypothetical custom targets
""let g:surr_target_{char2nr("v")} = ["\\lvert","\\rvert"]
"let g:surr_target_118 = ["\\lvert","\\rvert"]
"let g:surr_target_{char2nr("V")} = ['\lVert','\rVert']

"
"
" existing capability
let g:surround_{char2nr("q")} = "`\r'"
let g:surround_{char2nr("Q")} = "``\r''"

" hypothetical custom targets
" let g:surr_target_{char2nr("q")} = ['`',"\'"]
" let g:surr_target_{char2nr("Q")} = ['``',"\'\'"]
" hypothetical custom targets
" let g:surr_target_{char2nr("q")} = ['‘','’']
" let g:surr_target_{char2nr("Q")} = ['“','”']



call textobj#user#plugin('rmarkdown', {
\   'environment': {
\     '*pattern*': ['\\begin{[^}]\+}.*\n\s*', '\n^\s*\\end{[^}]\+}.*$'],
\     'select-a': 'ae',
\     'select-i': 'ie',
\   },
\  'bracket-math': {
\     '*pattern*': ['\\\[', '\\\]'],
\     'select-a': 'au',
\     'select-i': 'iu',
\   },
\  'paren-math': {
\     '*pattern*': ['\\(', '\\)'],
\     'select-a': 'a\',
\     'select-i': 'i\',
\   },
\  'dollar-math-a': {
\     '*pattern*': '[$][^$]*[$]',
\     'select': 'a$',
\   },
\  'dollar-math-i': {
\     '*pattern*': '[$]\zs[^$]*\ze[$]',
\     'select': 'i$',
\   },
\  'quote': {
\     '*pattern*': ['`', "'"],
\     'select-a': 'aq',
\     'select-i': 'iq',
\   },
\  'double-quote': {
\     '*pattern*': ['``', "''"],
\     'select-a': 'aQ',
\     'select-i': 'iQ',
\   },
\  'biglimiter': {
\     '*pattern*': ['\\{', '\\}'],
\     'select-a': 'aU',
\     'select-i': 'iU',
\   },
\ })

