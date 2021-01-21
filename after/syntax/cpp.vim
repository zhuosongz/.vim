" Vim syntax file
" Language: C++ Additions
" Maintainer: Jon Haggblad <jon@haeggblad.com>
" URL: http://www.haeggblad.com
" Last Change: 1 Feb 2018
" Version: 0.6
" Changelog:
"   0.1 - initial version.
"   0.2 - C++14
"   0.3 - Incorporate lastest changes from Mizuchi/STL-Syntax
"   0.4 - Add template function highlight
"   0.5 - Redo template function highlight to be more robust. Add options.
"   0.6 - more C++14, C++17, library concepts
"
" Additional Vim syntax highlighting for C++ (including C++11/14/17)
"
" This file contains additional syntax highlighting that I use for C++11/14
" development in Vim. Compared to the standard syntax highlighting for C++ it
" adds highlighting of (user defined) functions and the containers and types
" in the standard library / boost.
"
" Based on:
"   http://stackoverflow.com/q/736701
"   http://www.vim.org/scripts/script.php?script_id=4293
"   http://www.vim.org/scripts/script.php?script_id=2224
"   http://www.vim.org/scripts/script.php?script_id=1640
"   http://www.vim.org/scripts/script.php?script_id=3064


" -----------------------------------------------------------------------------
"  Highlight Class and Function names.
"
" Based on the discussion in: http://stackoverflow.com/q/736701
" -----------------------------------------------------------------------------

" Functions
if !exists('g:cpp_no_function_highlight')
    syn match   cCustomParen    transparent "(" contains=cParen contains=cCppParen
    syn match   cCustomFunc     "\w\+\s*(\@="
    hi def link cCustomFunc  Function
endif

" Class and namespace scope
if exists('g:cpp_class_scope_highlight') && g:cpp_class_scope_highlight
    syn match   cCustomScope    "::"
    syn match   cCustomClass    "\w\+\s*::"
                \ contains=cCustomScope
    hi def link cCustomClass Function
endif

" Clear cppStructure and replace "class" and/or "template" with matches
" based on user configuration
let s:needs_cppstructure_match = 0
if exists('g:cpp_class_decl_highlight') && g:cpp_class_decl_highlight
	let s:needs_cppstructure_match += 1
endif
if exists('g:cpp_experimental_template_highlight') && g:cpp_experimental_template_highlight
	let s:needs_cppstructure_match += 2
endif

syn clear cppStructure
if s:needs_cppstructure_match == 0
	syn keyword cppStructure typename namespace template class
elseif s:needs_cppstructure_match == 1
	syn keyword cppStructure typename namespace template
elseif s:needs_cppstructure_match == 2
	syn keyword cppStructure typename namespace class
elseif s:needs_cppstructure_match == 3
	syn keyword cppStructure typename namespace
endif
unlet s:needs_cppstructure_match


" Class name declaration
if exists('g:cpp_class_decl_highlight') && g:cpp_class_decl_highlight
	syn match cCustomClassKey "\<class\>"
	hi def link cCustomClassKey cppStructure

	" Clear cppAccess entirely and redefine as matches
	syn clear cppAccess
	syn match cCustomAccessKey "\<private\>"
	syn match cCustomAccessKey "\<public\>"
	syn match cCustomAccessKey "\<protected\>"
	hi def link cCustomAccessKey cppAccess

	" Match the parts of a class declaration
	syn match cCustomClassName "\<class\_s\+\w\+\>"
				\ contains=cCustomClassKey
	syn match cCustomClassName "\<private\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	syn match cCustomClassName "\<public\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	syn match cCustomClassName "\<protected\_s\+\w\+\>"
				\ contains=cCustomAccessKey
	hi def link cCustomClassName Function
endif
" Template functions.
" Naive implementation that sorta works in most cases. Should correctly
" highlight everything in test/color2.cpp
if exists('g:cpp_experimental_simple_template_highlight') && g:cpp_experimental_simple_template_highlight
    syn region  cCustomAngleBrackets matchgroup=AngleBracketContents start="\v%(<operator\_s*)@<!%(%(\_i|template\_s*)@<=\<[<=]@!|\<@<!\<[[:space:]<=]@!)" end='>' contains=@cppSTLgroup,cppStructure,cType,cCustomClass,cCustomAngleBrackets,cNumbers
    syn match   cCustomBrack    "<\|>" contains=cCustomAngleBrackets
    syn match   cCustomTemplateFunc "\w\+\s*<.*>(\@=" contains=cCustomBrack,cCustomAngleBrackets
    hi def link cCustomTemplateFunc  Function

" Template functions (alternative faster parsing).
" More sophisticated implementation that should be faster but doesn't always
" correctly highlight inside template arguments. Should correctly
" highlight everything in test/color.cpp
elseif exists('g:cpp_experimental_template_highlight') && g:cpp_experimental_template_highlight

    syn match   cCustomAngleBracketStart "<\_[^;()]\{-}>" contained
                \ contains=cCustomAngleBracketStart,cCustomAngleBracketEnd
    hi def link cCustomAngleBracketStart  cCustomAngleBracketContent

    syn match   cCustomAngleBracketEnd ">\_[^<>;()]\{-}>" contained
                \ contains=cCustomAngleBracketEnd
    hi def link cCustomAngleBracketEnd  cCustomAngleBracketContent

    syn match cCustomTemplateFunc "\<\l\w*\s*<\_[^;()]\{-}>(\@="hs=s,he=e-1
                \ contains=cCustomAngleBracketStart
    hi def link cCustomTemplateFunc  cCustomFunc

    syn match    cCustomTemplateClass    "\<\w\+\s*<\_[^;()]\{-}>"
                \ contains=cCustomAngleBracketStart,cCustomTemplateFunc
    hi def link cCustomTemplateClass cCustomClass

    syn match   cCustomTemplate "\<template\>"
    hi def link cCustomTemplate  cppStructure
    syn match   cTemplateDeclare "\<template\_s*<\_[^;()]\{-}>"
                \ contains=cppStructure,cCustomTemplate,cCustomClassKey,cCustomAngleBracketStart

    " Remove 'operator' from cppOperator and use a custom match
    syn clear cppOperator
    syn keyword cppOperator typeid
    syn keyword cppOperator and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq

    syn match   cCustomOperator "\<operator\>"
    hi def link cCustomOperator  cppStructure
    syn match   cTemplateOperatorDeclare "\<operator\_s*<\_[^;()]\{-}>[<>]=\?"
                \ contains=cppOperator,cCustomOperator,cCustomAngleBracketStart
endif

" Alternative syntax that is used in:
"  http://www.vim.org/scripts/script.php?script_id=3064
"syn match cUserFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
"hi def link cCustomFunc  Function

" Cluster for all the stdlib functions defined below
syn cluster cppSTLgroup     contains=cppSTLfunction,cppSTLfunctional,cppSTLconstant,cppSTLnamespace,cppSTLtype,cppSTLexception,cppSTLiterator,cppSTLiterator_tag,cppSTLenum,cppSTLios,cppSTLcast


" -----------------------------------------------------------------------------
"  Standard library types and functions.
"
" Mainly based on the excellent STL Syntax vim script by
" Mizuchi <ytj000@gmail.com>
"   http://www.vim.org/scripts/script.php?script_id=4293
" which in turn is based on the scripts
"   http://www.vim.org/scripts/script.php?script_id=2224
"   http://www.vim.org/scripts/script.php?script_id=1640
" -----------------------------------------------------------------------------

" syntax keyword cppSTLtype locale




syntax keyword cppSTLtype Mat
syntax keyword cppSTLtype mat
syntax keyword cppSTLtype cx_mat
syntax keyword cppSTLtype Col
syntax keyword cppSTLtype colvec
syntax keyword cppSTLtype vec
syntax keyword cppSTLtype Row
syntax keyword cppSTLtype rowvec
syntax keyword cppSTLtype 
syntax keyword cppSTLtype Cube
syntax keyword cppSTLtype cube
syntax keyword cppSTLtype cx_cube
syntax keyword cppSTLtype field
syntax keyword cppSTLtype SpMat
syntax keyword cppSTLtype sp_mat
syntax keyword cppSTLtype sp_cx_mat


syntax keyword cppSTLfunction attributes
syntax keyword cppSTLfunction element access
syntax keyword cppSTLfunction element initialisation
syntax keyword cppSTLfunction .zeros
syntax keyword cppSTLfunction .ones
syntax keyword cppSTLfunction .eye
syntax keyword cppSTLfunction .randu
syntax keyword cppSTLfunction .randn
syntax keyword cppSTLfunction .fill
syntax keyword cppSTLfunction .imbue
syntax keyword cppSTLfunction .replace
syntax keyword cppSTLfunction .transform
syntax keyword cppSTLfunction .for_each
syntax keyword cppSTLfunction .set_size
syntax keyword cppSTLfunction .reshape
syntax keyword cppSTLfunction .resize
syntax keyword cppSTLfunction .copy_size
syntax keyword cppSTLfunction .reset
syntax keyword cppSTLfunction submatrix views
syntax keyword cppSTLfunction subcube views
syntax keyword cppSTLfunction subfield views
syntax keyword cppSTLfunction .diag
syntax keyword cppSTLfunction .each_col
syntax keyword cppSTLfunction .each_row
syntax keyword cppSTLfunction .each_slice
syntax keyword cppSTLfunction .set_imag
syntax keyword cppSTLfunction .set_real
syntax keyword cppSTLfunction .insert_rows
syntax keyword cppSTLfunction .insert_cols
syntax keyword cppSTLfunction .insert_slices
syntax keyword cppSTLfunction .shed_rows/cols/slices
syntax keyword cppSTLfunction .swap_rows/cols
syntax keyword cppSTLfunction .swap
syntax keyword cppSTLfunction .memptr
syntax keyword cppSTLfunction .colptr
syntax keyword cppSTLfunction .t
syntax keyword cppSTLfunction .st
syntax keyword cppSTLfunction .i
syntax keyword cppSTLfunction .min
syntax keyword cppSTLfunction .max
syntax keyword cppSTLfunction .index_min
syntax keyword cppSTLfunction .index_max
syntax keyword cppSTLfunction .eval
syntax keyword cppSTLfunction .in_range
syntax keyword cppSTLfunction .is_empty
syntax keyword cppSTLfunction .is_square
syntax keyword cppSTLfunction .is_vec
syntax keyword cppSTLfunction .is_sorted
syntax keyword cppSTLfunction .is_finite
syntax keyword cppSTLfunction .has_inf
syntax keyword cppSTLfunction .has_nan
syntax keyword cppSTLfunction .print
syntax keyword cppSTLfunction .raw_print
syntax keyword cppSTLfunction .save/.load (matrices & cubes)
syntax keyword cppSTLfunction .save/.load (fields)
" Generated Vectors/Matrices/Cubes
syntax keyword cppSTLfunction eye
syntax keyword cppSTLfunction linspace
syntax keyword cppSTLfunction logspace
syntax keyword cppSTLfunction ones
syntax keyword cppSTLfunction randi
syntax keyword cppSTLfunction randu
syntax keyword cppSTLfunction randn
syntax keyword cppSTLfunction randg
syntax keyword cppSTLfunction regspace
syntax keyword cppSTLfunction speye
syntax keyword cppSTLfunction spones
syntax keyword cppSTLfunction sprandu
syntax keyword cppSTLfunction sprandn
syntax keyword cppSTLfunction toeplitz
syntax keyword cppSTLfunction zeros
" Functions of Vectors/Matrices/Cubes
syntax keyword cppSTLfunction abs
syntax keyword cppSTLfunction accu
syntax keyword cppSTLfunction affmul
syntax keyword cppSTLfunction all
syntax keyword cppSTLfunction any
syntax keyword cppSTLfunction approx_equal
syntax keyword cppSTLfunction arg
syntax keyword cppSTLfunction as_scalar
syntax keyword cppSTLfunction clamp
syntax keyword cppSTLfunction cond
syntax keyword cppSTLfunction conj
syntax keyword cppSTLfunction conv_to
syntax keyword cppSTLfunction cross
syntax keyword cppSTLfunction cumsum
syntax keyword cppSTLfunction cumprod
syntax keyword cppSTLfunction det
syntax keyword cppSTLfunction diagmat
syntax keyword cppSTLfunction diagvec
syntax keyword cppSTLfunction diff
syntax keyword cppSTLfunction dot / cdot / norm_dot
syntax keyword cppSTLfunction eps
syntax keyword cppSTLfunction expmat
syntax keyword cppSTLfunction expmat_sym
syntax keyword cppSTLfunction find
syntax keyword cppSTLfunction find_finite
syntax keyword cppSTLfunction find_nonfinite
syntax keyword cppSTLfunction find_unique
syntax keyword cppSTLfunction fliplr
syntax keyword cppSTLfunction flipud
syntax keyword cppSTLfunction ima
syntax keyword cppSTLfunction real
syntax keyword cppSTLfunction ind2sub
syntax keyword cppSTLfunction index_min
syntax keyword cppSTLfunction index_max
syntax keyword cppSTLfunction inplace_trans
syntax keyword cppSTLfunction intersect
syntax keyword cppSTLfunction is_finite
syntax keyword cppSTLfunction join_rows
syntax keyword cppSTLfunction join_cols
syntax keyword cppSTLfunction join_slices
syntax keyword cppSTLfunction kron
syntax keyword cppSTLfunction log_det
syntax keyword cppSTLfunction logmat
syntax keyword cppSTLfunction logmat_sympd
syntax keyword cppSTLfunction min
syntax keyword cppSTLfunction max
syntax keyword cppSTLfunction nonzeros
syntax keyword cppSTLfunction norm
syntax keyword cppSTLfunction normalise
syntax keyword cppSTLfunction prod
syntax keyword cppSTLfunction rank
syntax keyword cppSTLfunction rcond
syntax keyword cppSTLfunction repelem
syntax keyword cppSTLfunction repmat
syntax keyword cppSTLfunction reshape
syntax keyword cppSTLfunction resize
syntax keyword cppSTLfunction reverse
syntax keyword cppSTLfunction roots
syntax keyword cppSTLfunction shift
syntax keyword cppSTLfunction shuffle
syntax keyword cppSTLfunction size
syntax keyword cppSTLfunction sort
syntax keyword cppSTLfunction sort_index
syntax keyword cppSTLfunction sqrtmat
syntax keyword cppSTLfunction sqrtmat_sympd
syntax keyword cppSTLfunction sum
syntax keyword cppSTLfunction sub2ind
syntax keyword cppSTLfunction symmatu
syntax keyword cppSTLfunction symmatl
syntax keyword cppSTLfunction trace
syntax keyword cppSTLfunction trans
syntax keyword cppSTLfunction trapz
syntax keyword cppSTLfunction trimatu
syntax keyword cppSTLfunction trimatl
syntax keyword cppSTLfunction unique
syntax keyword cppSTLfunction vectorise
syntax keyword cppSTLfunction misc functions
syntax keyword cppSTLfunction trig functions
syntax keyword cppSTLfunction 
syntax keyword cppSTLfunction chol
syntax keyword cppSTLfunction eig_sym
syntax keyword cppSTLfunction eig_gen
syntax keyword cppSTLfunction eig_pair
syntax keyword cppSTLfunction inv
syntax keyword cppSTLfunction inv_sympd
syntax keyword cppSTLfunction lu
syntax keyword cppSTLfunction null
syntax keyword cppSTLfunction orth
syntax keyword cppSTLfunction pinv
syntax keyword cppSTLfunction qr
syntax keyword cppSTLfunction qr_econ
syntax keyword cppSTLfunction qz
syntax keyword cppSTLfunction schur
syntax keyword cppSTLfunction solve
syntax keyword cppSTLfunction svd
syntax keyword cppSTLfunction svd_econ
syntax keyword cppSTLfunction syl
syntax keyword cppSTLfunction eigs_sym
syntax keyword cppSTLfunction eigs_gen
syntax keyword cppSTLfunction spsolve
syntax keyword cppSTLfunction svds
syntax keyword cppSTLfunction conv
syntax keyword cppSTLfunction conv2
syntax keyword cppSTLfunction fft
syntax keyword cppSTLfunction ifft
syntax keyword cppSTLfunction fft2
syntax keyword cppSTLfunction ifft2
syntax keyword cppSTLfunction interp1
syntax keyword cppSTLfunction polyfit
syntax keyword cppSTLfunction polyval
syntax keyword cppSTLfunction cov
syntax keyword cppSTLfunction cor
syntax keyword cppSTLfunction hist
syntax keyword cppSTLfunction histc
syntax keyword cppSTLfunction princomp
syntax keyword cppSTLfunction normpdf
syntax keyword cppSTLfunction normcdf
syntax keyword cppSTLfunction mvnrnd
syntax keyword cppSTLfunction chi2rnd
syntax keyword cppSTLfunction wishrnd
syntax keyword cppSTLfunction iwishrnd
syntax keyword cppSTLfunction running_stat
syntax keyword cppSTLfunction running_stat_vec
syntax keyword cppSTLfunction kmeans


