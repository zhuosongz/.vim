" call  TexNewMathZone('Env','equ',1)
call vimtex#syntax#core#new_region_math('equ')
call vimtex#syntax#core#new_region_math('esplit')

match ErrorMsg '\%>500v.\+'

syn region texMathRegionEnv matchgroup=texDelim contains=@texClusterMath  start="\\\(be\|ben\|bes\|besn\|bs\|ba\|ban\|bg\|bgn\|bm\|bmn\){" end="}" 
