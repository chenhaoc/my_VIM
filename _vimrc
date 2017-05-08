set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"autocmd! bufwritepost $MYVIMRC source %

filetype on
set encoding=utf-8
if has("win32")
  lang message zh_CN.UTF-8
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
endif
set guifont=Consolas:h12:cANSI
"set guifontwide=幼圆:h12:cGB2312
set lines=30 columns=100
set nu!
set hlsearch
"set cindent
set autoindent
set cursorline           " 突出显示当前行
set nobackup
set wrap            "设置自动换行显示
set cc=80           "高亮80列 cc=colorcolumn
set textwidth=80    "设置到80自动换行

"set background=light
set background=dark
"colorscheme murphy
colorscheme solarized
call togglebg#map("<F3>")
let g:solarized_menu = 0
let g:solarized_italic=1

"autocmd FileType verilog set background=dark
"au! BufRead,BufNewFile *.v,*.vh colorscheme murphy_ch
au! BufRead,BufNewFile *.v,*.vh, set filetype=verilog
autocmd FileType verilog colorscheme murphy_ch
syntax enable

syntax on
set showtabline=2
set softtabstop=4
set shiftwidth=4
set expandtab

set foldenable "启动折叠
set foldmethod=indent "按照缩进进行折叠
set foldlevel=99 " 启动vim时不要自动折叠代码

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {<CR>}<ESC>O
"inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i
inoremap <= <= #`DLY
function! ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
 else
     return a:char
 endif
endfunction

" Keymap {{{
let mapleader=","
map tn :tabnew<cr> "打开新标签页
map tc :tabclose<cr> "关闭新标签页

"alt key not to active menu
set winaltkeys=no "alt键不激活菜单栏

"改写单词，光标不在单词词首也能改写
nnoremap cw lbcw

":q 经常被输成:Q 让:Q 也能退出
map :Q :q
"Alt-q 退出
map <M-q> :q<Cr>

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
imap <S-Tab> <C-p>

"Alt键+hjkl 在编辑模式下进行移动
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>

nmap <leader>s :source $MYVIMRC<cr>
"nmap <leader>s :source /$VIM/_vimrc<cr>

"nmap <leader>e :e /$VIM/_vimrc<cr>
nmap <leader>e :e $MYVIMRC<cr>

"<M>指Alt键，普通模式下alt-j/k将整行向下移/上移
nmap <M-j> ddp
nmap <M-k> kddpk
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
inoremap <C-j> <ESC><C-w>j
inoremap <C-h> <ESC><C-w>h
inoremap <C-k> <ESC><C-w>k
inoremap <C-l> <ESC><C-w>l


filetype plugin indent on
" 这条很重要！！！！注释掉会到时后面的补全设置都乱掉
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType systemverilog,verilog set shiftwidth=4
"设置自动单词高亮
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"通过变量设置自动高亮开关
"let HlUnderCursor=1
"autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""

"for Ctags
set tags=tags;
set autochdir

function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'  "行首到光标处都是空格，tap
    return "\<Tab>"
  else
  if strpart( getline('.'), col('.')-2, 2) =~ '\s$' "当前光标前一个字母是空格，tap
    return "\<Tab>"
  else
    return "\<C-N>"  "否则Tap补全，相当于有字母才补全
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

inoremap <C-L> <C-X><C-L>
noremap <F2> *N
inoremap <F2> <ESC>*N


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"all vundle#begin()
"set rtp+=$HOME\vimfiles\bundle\Vundle.vim\
"call vundle#rc('$USERPROFILE\vimfiles\bundle\')
set rtp+=$VIM\bundle\Vundle.vim\
call vundle#rc('$VIM\bundle\')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
Bundle 'Lokaltog/vim-powerline'
Bundle 'klen/python-mode'
Bundle 'andviro/flake8-vim'
Bundle 'bad-whitespace'
Bundle 'hdima/python-syntax'
Bundle 'tmhedberg/SimpylFold'
"Bundle 'vim-scripts/indentpython.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'AutoComplPop'
Bundle 'scrooloose/nerdtree'
Bundle 'davidhalter/jedi-vim'
Bundle 'ctrlpvim/ctrlp.vim'
"Bundle 'ervandew/supertab'
Bundle 'taglist.vim'
Bundle 'TxtBrowser'
"快速批量注释插件<lead>c<space> 切换注释
Bundle 'The-NERD-Commenter'
Bundle 'matlab.vim'
"Bundle 'nachumk/systemverilog.vim'
Bundle 'vhda/verilog_systemverilog.vim'
"Bundle 'WeiChungWu/vim-SystemVerilog'

"Bundle 'SuperTap
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
""Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"--------------------------------------------------------------------------------
"SimpylFold
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring=0


"--------------------------------------------------------------------------------
"nerdtree
map <F12> :NERDTreeToggle<CR>

"au BufNewFile,BufRead *.py
"    \ set tabstop=4  |
"    \ set softtabstop=4  |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix

"--------------------------------------------------------------------------------
"syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
""let g:syntastic_python_checkers=['python']
"let g:syntastic_enable_signs=1


"--------------------------------------------------------------------------------
"flake8-vim
let g:PyFlakeOnWrite = 0   "保存时不检查，按F7手动检查
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10
let g:PyFlakeCWindow = 4 "最多占四行
let g:PyFlakeSigns = 1
au BufNewFile,BufRead *.py nmap <F4> :PyFlakeAuto<CR>   "F4 自动修正pep8错误
au BufNewFile,BufRead *.py nmap <F5> :w\|!python %<CR>   "保存并运行当前python文件
au BufNewFile,BufRead *.py nmap <F7> :PyFlake<CR>   "F7 运行检查语法

"--------------------------------------------------------------------------------
" Python-mode
" Activate rope
" Keys: 按键：
" K             Show python docs 显示Python文档
" <Ctrl-Space>  Rope autocomplete  使用Rope进行自动补全
" <Ctrl-c>g     Rope goto definition  跳转到定义处
" <Ctrl-c>d     Rope show documentation  显示文档
" <Ctrl-c>f     Rope find occurrences  寻找该对象出现的地方
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled) 断点
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
"            跳转到前一个/后一个类或函数
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
"              跳转到前一个/后一个类或方法
"打开pymode
let g:pymode = 1
"Setup default python options
let g:pymode_options = 1
"自带的pymode_rope感觉并不是很好用，AutoComplPop的补全就挺好,还有jedi-vim
let g:pymode_rope = 0

" Documentation 显示文档
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting 代码查错，=1为启用
let g:pymode_lint = 1
let g:pymode_lint_checker = ['pyflakes', 'pep8', 'mccabe']
" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_unmodified = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" Don't autofold code 禁用自动代码折叠
let g:pymode_folding = 0

"Binds keys to run python code
let g:pymode_run = 1
let g:pymode_run_bind = '<F6>' "<F6>运行py程序，当前打开一个窗口运行显示结果。

let g:pymode_quickfix_minheight = 2
let g:pymode_quickfix_maxheight = 6
"python-mode设置了不自动换行显示，打开好
au BufNewFile,BufRead *.py set wrap

"--------------------------------------------------------------------------------
"jedi
"let g:pymode_rope = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1   "=0有bug
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>j"
let g:jedi#documentation_command = ""
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"let g:jedi#rename_command = ""


"--------------------------------------------------------------------------------
"ctrlp
"let g:ctrlp_map = '<leader>p'
"let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
map <leader>b :CtrlPBuffer<CR>

let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=10
let g:ctrlp_show_hidden = 0
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=100
"the newly created file is to be opened when pressing <c-y>   t - in a new tab. h - in a new horizontal split. v - in a new vertical split. r - in the current window.
let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 't'

"--------------------------------------------------------------------------------
"TxtBrowser
"TXT log 文本高亮
"syntax on   "added previous
"filetype plugin on   "added previous
au BufRead,BufNewFile *.txt,*.log  setlocal ft=txt

"--------------------------------------------------------------------------------
"taglist.vim
map <F11> :TlistToggle<CR>

"--------------------------------------------------------------------------------
"NERD_commenter
let NERDMenuMode = 0  "1显示menu，0不显示
",<space>切换注释与否
map <leader><space> <plug>NERDCommenterToggle
",cS切换注释风格
map <leader>cS <plug>NERDCommenterAltDelims
",ca在行尾添加注释
map <leader>ca <plug>NERDCommenterAppend
",cb 或 ,cl 对齐注释 ,cs 风骚注释 ,cc 加注释 ,cu 取消注释


"--------------------------------------------------------------------------------
"verilog
let g:VERILOG_AuthorName   = "chenhaoc"
let g:VERILOG_AuthorRef    = "PKUSZ.IMS"
let g:VERILOG_Email        = "chenhaoc@sz.pku.edu.cn"

"--------------------------------------------------------------------------------
" hicursorwords
" D:\Program Files (x86)\Vim\vimfiles\plugin\hicursorwords.vim
let g:HiCursorWords_delay = 200
let g:HiCursorWords_hiGroupRegexp =''
let g:HiCursorWords_debugEchoHiName = 0

"--------------------------------------------------------------------------------
" bad-whitespace
" :EraseBadWhitespace "消除所有whitespace


"--------------------------------------------------------------------------------
" System Verilog
"au BufRead,BufNewFile *.sv,*.sva  set filetype=systemverilog
"

"--------------------------------------------------------------------------------
"设置打开新verilog文件自动增加文件头
"--------------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.v exec ":call SetTitle()"
let $project_name = "ECG_ASIC"
let $author_name = "chenhaoc"
let $author_email = "chenhaoc@sz.pku.edu.cn"

func! SetTitle()
  if line("$")==1 && getline(1)==""
    "call append(line(".")+1, "\# Author: ".$author_name)
    call setline(1,"// ********************************************************")
    call setline(2,"// Copyright(c)  2017  IMS&SoC Lab")
    call setline(3,"// Project name  :  ".$project_name)
    call setline(4,"// Author        :  ".$author_name)
    call setline(5,"// File    name  :  ".expand("%"))
    call setline(6,"// Module  name  :  ".expand("%:r"))
    call setline(7,"// Created Time  :  ".strftime("%c"))
    call setline(8,"// Last Modified :  ".strftime("%c"))
    call setline(9,"// Abstract:")
    call setline(10,"")
    call setline(11,"// ========================================================")
    call setline(12,"// Revision     Date     Author      Comment")
    call setline(13,"// --------  ---------  ---------    ---------")
    call setline(14,"//   1.0    ".strftime("%Y/%m/%d  ").$author_name)
    call setline(15,"//")
    call setline(16,"// ********************************************************")
    call setline(17,"")
    call setline(18,"`define DLY 1")
    call setline(19,"`timescale 1ns/10ps")
    call setline(20,"")
    call setline(21,"module ".expand("%:r"))
    call cursor(21,1)
    startinsert!
  endif
endfunction
" 在文件中间添加版本注释信息，上下都有分隔 使用方法 :call Add_full_revision 可用tap补全函数名
func! Add_full_revision()
  call append(line("."),"// ========================================================")
  call append(line(".")+1,"// Revision     Date     Author      Comment")
  call append(line(".")+2,"// --------  ---------  ---------    ---------")
  call append(line(".")+3,"//   x.x    ".strftime("%Y/%m/%d  ").$author_name)
  call append(line(".")+4,"//")
  call append(line(".")+5,"// ========================================================")
endfunction
" 在头文件里添加一版版本，只有上面有分隔,使用方法 :call Add_brief_revision 可用tap补全函数名
" 建议使用这个函数增加版本信息 :call A<tap>
func! Add_brief_revision()
  call append(line("."),"// --------------------------------------------------------")
  call append(line(".")+1,"//   x.x    ".strftime("%Y/%m/%d  ").$author_name)
  call append(line(".")+2,"//")
endfunc
" 保存时自动更新保存时间
func! SetLastModifiedTime()
    let line = getline(8)
    if match(line,"Last Modified") != -1
        call setline(8,"// Last Modified :  ".strftime("%c"))
    endif
endfunction
au BufWrite *.v call SetLastModifiedTime()
"--------------------------------------------------------------------------------
