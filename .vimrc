" System vimrc file for MacVim
"
" Maintainer:	Bjorn Winckler <bjorn.winckler@gmail.com>
" Last Change:	Sat Aug 29 2009

" ==> 重新定义一些保存、退出的命令，因为会按到大写字母 -------------------------------{{{1
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif
" ... 
" ==>  设置中文环境 ------------------------------------------------------------------{{{1
if has("gui_running")
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,chinese,prc,taiwan,latin-1

    if has("win32")
        set fileencoding=chinese
    else
        set fileencoding=utf-8
    endif

    let &termencoding=&encoding

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8
endif
" ==> 设置备份文件存储位置 -----------------------------------------------------------{{{1
" set backup
" set backupdir=$HOME/.vim/tmp/backup/
" set directory=$HOME/.vim/tmp/swp/
set undofile
set undodir=$HOME/.vim/tmp/undo
" set nobackup! "不生成备份文件（~文件）。



" ==> 插件 ---------------------------------------------------------------------------{{{1
set nocompatible
filetype plugin indent on
syntax on
" set pyxversion=3
" let g:python3_host_prog="/usr/local/bin/python3"
" ===============================================================
" plug setting 
call plug#begin('~/Dropbox/config/vim/.vim/bundle')
"
" Plugins 
" }}}
" ==> git 插件 ----------------------------------------------------------------------{{{2
Plug 'tpope/vim-fugitive'
" 定义textobj 模块
" ==> textobj 插件 ----------------------------------------------------------------------{{{2
Plug 'kana/vim-textobj-user'
Plug 'rbonvall/vim-textobj-latex'
Plug 'pocke/vim-textobj-markdown'
Plug 'tpope/vim-surround'

" ==> 

" ==> 主题 插件 ----------------------------------------------------------------------{{{2
Plug 'altercation/vim-colors-solarized'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-abolish'
Plug 'osyo-manga/vim-over'

" " ==> complete 插件 ------------------------------------------------------------------{{{2
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

" ==> snippets 插件 ----------------------------------------------------------------------{{{2
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Unisnips
" 
" Track the engine.
" Plug 'neoclide/coc-snippets'
" Use release branch (recommend)
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<S-tab>'


" ==> align 插件 ----------------------------------------------------------------------{{{2
"
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"
" ==> latex 插件 ----------------------------------------------------------------------{{{2
" latex 配置
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_syntax_enable=1
autocmd! BufNewFile,BufRead *.tex set filetype=tex


" ==> 其他 插件 ----------------------------------------------------------------------{{{2
" 用句点重高级插件
Plug 'tpope/vim-repeat'
" 添加注释的插件 用 gc 切换
Plug 'tpope/vim-commentary'
" undo tree 
"
Plug 'mbbill/undotree'
Plug 'hotoo/pangu.vim'
Plug 'poppyschmo/deoplete-latex'
" 自动运行
Plug 'skywind3000/asyncrun.vim'


"
"
"filetype plugin indent on
call plug#end()            " required



" ==> 界面设置 ----------------------------------------------------------------------{{{1
" 显示行号
if &co > 80
	set number
endif
set rnu                   " 显示相对行号
set shiftwidth=4
set autoindent            " 自动对齐
set nohls!                " 全局性地关闭令人讨厌的模式高亮（特别是换行符）：
match DiffAdd '\%>110v.*' " 文档的一行不超过110个字符
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set so=1
" set cursorline            " 突出显示当前行
" set sidescroll=1
set makeprg=make
set tabstop=4
set softtabstop=4
set shiftwidth=4
set fdc=2 
set showcmd               " 显示未完成的命令
set noerrorbells          " 关闭警告提示音
set vb t_vb=
set ruler                 " 右下角显示位置

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set bg=dark
" set sidescrolloff=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
set formatoptions+=m      " 允许对中文换行。
set hlsearch
set tw=110
set lines=30
set columns=110
set numberwidth=6
set linebreak "在合适的地方折行 按单词折行
let &showbreak= repeat(' ', 3) . '↳  '
set cpo+=n 
set complete=.,w,b
set fdm=marker
" colorscheme solarized
set background=light

" 打开文件时恢复光标位置
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

