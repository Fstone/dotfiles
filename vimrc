" 关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible
set guifont=Monaco:h14
" 配置backspace键工作方式
set backspace=indent,eol,start
" 显示行号
set number
nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>
" 设置在编辑过程中右下角显示光标的行列信息
set ruler
" 当一行文字很长时取消换行
set nowrap
" 在状态栏显示正在输入的命令
set showcmd
" 设置历史记录条数
set history=100
" 设置取消备份 禁止临时文件生成
set nobackup
set noswapfile
" 突出现实当前行列、高亮当前行列
set cursorline
set cursorcolumn
" 设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch
" 设置C/C++方式自动对齐
set autoindent
set cindent

set hlsearch

" 开启语法高亮功能
syntax enable syntax on
" 指定配色方案为256色
set t_Co=256
" 设置搜索时忽略大小写
set ignorecase
" 设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a
" 设置Tab宽度
set tabstop=4
" 设置自动对齐空格数
set shiftwidth=4
" 设置按退格键时可以一次删除4个空格
set softtabstop=4
" 设置按退格键时可以一次删除4个空格
set smarttab
" 将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab
" 设置编码方式
set encoding=utf-8
" 自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 检测文件类型
filetype on
" 针对不同的文件采用不同的缩进方式
filetype indent on
" 允许插件
filetype plugin on
" 启动智能补全
filetype plugin indent on

"===================================================================
"===================================================================
"
"   自定义vim操作
"
"====================================================================
"====================================================================
map <F5> :call Do_OneFileMake()<CR>
map <F2> :call Do_FileSave()<CR>
map <F3> :call Do_FileSaveAndQuit()<CR>

" === 当前文件保存 ===
function Do_FileSave()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "w"
endfunction

" === 当前文件保存退出 ===
function Do_FileSaveAndQuit()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "wq"
endfunction

" === 单文件编译 仅支持c、cc、cpp、go文件 ===
function Do_OneFileMake()
    if expand("%:p:h")!=getcwd()
        echoh1 WarningMsg | echo "Failed to make. This's file is not in the current dir." | echoh1 None
        return
    endif

    let source_file_name=expand("%:t")

    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    if ( (&filetype!="c")&&(&filetype!="cc")&&(&filetype!="cpp")&&(&filetype!="go") )
    echoh1 WarningMsg | echo "Please just make c、cc、cpp and go file." | echoh1 None
        return
    endif

    if &filetype=="c"
        set makeprg=gcc\ %\ -o\ %<
    endif

    execute "w"
    execute "silent make"
    execute "q"
endfunction


"==============================================================
"==============================================================
"
"   Vundle插件管理和配置项
"
"==============================================================
"==============================================================

" 开始使用Vundle的必须配置
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/vim-colors-solarized
call vundle#begin()
" === 使用Vundle来管理Vundle ===
Plugin 'VundleVim/Vundle.vim'
" === PowerLine插件 状态栏增强展示 ===
Plugin 'Lokaltog/vim-powerline'
" vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
let g:Powline_symbols='fancy'
" === The-NERD-tree 目录导航插件 ===
Plugin 'vim-scripts/The-NERD-tree'
" 开启目录导航快捷键映射成n键
nnoremap <C-t> :NERDTreeToggle<CR>
" 高亮鼠标所在的当前行
let NERDTreeHighlightCursorline=1
" === Tagbar 标签导航 ===
Plugin 'majutsushi/tagbar'
" 标签导航快捷键
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" === A 头文件和实现文件自动切换插件 ===
Plugin 'vim-scripts/a.vim'
" 将切换的快捷键映射成<F4>
nnoremap <silent> <F4> :A<CR>
"=== ctrlp 文件搜索插件 不需要外部依赖包 ===
Plugin 'kien/ctrlp.vim'
" 设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
" 设置默认忽略搜索的文件格式
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
" 设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15
" === YouCompleteMe 自动补全插件===
Plugin 'Valloric/YouCompleteMe'

" 自动补全配置插件路径
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 1
"youcompleteme 默认tab s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"let g:UltiSnipsExpandTrigger="<c-j>"
" 当选择了一项后自动关闭自动补全提示窗口
"let g:ycm_autoclose_preview_window_after_completion=1

" === 自动补全单引号、双引号、括号等 ===
Plugin 'Raimondi/delimitMate'
" === 主题solarized ===
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
" === 主题 molokai ===
"Plugin 'tomasr/molokai'
" 设置主题 colorscheme molokai
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
" === indentLine代码排版缩进标识 ===
Plugin 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
" 缩进的显示标识|
let g:indentLine_char = '¦'
" === vim-trailing-whitespace将代码行最后无效的空格标红 ===
Plugin 'bronson/vim-trailing-whitespace'
" === markdown编辑插件 ===
Plugin 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1
" === golang编辑插件 ===
Plugin 'jnwhiteh/vim-golang'
" ==========================
" 其他推荐插件
" vim scripts
Plugin 'taglist.vim'
Plugin 'c.vim'
Plugin 'minibufexpl.vim'
Plugin 'grep.vim'
Plugin 'mru.vim'
Plugin 'comments.vim'
Plugin 'mattn/emmet-vim'
let g:user_emmet_expandabbr_key='<C-E>'
" 自动补全xml/html代码
Plugin 'xml.vim'
" json代码补全
Plugin 'JSON.vim'
" Python代码检查
Plugin 'pyflakes.vim'
" 提供命令模式下的补全
Plugin 'CmdlineComplete'
" 提供日历的功能，可以写日记
Plugin 'calendar.vim'
" 自动检测文件编码
Plugin 'FencView.vim'
" git repo
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/AutoClose'
Plugin 'scrooloose/syntastic'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-scripts/UltiSnips'
" 据说是革命性的移动方案，不知道有多革命性
Plugin 'Lokaltog/vim-easymotion'
" smali 语法高亮
Plugin 'alderz/smali-vim'
"Plugin 'kelwin/vim-smali'
" ==========================
call vundle#end()
" Vundle配置必须 开启插件
filetype plugin indent on
" syntastic
" ==========================
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1
" ==========================
""""""""""""ctags settings"""""""""""""""""
set tags+=~/.vim/cpptags
set tags+=~/.vim/systags
"""""""""""color scheme""""""""""""""""""""
let g:molokai_original=1
""""""""" Settings of taglist""""""""""""""
" increase the width of the taglist window
let Tlist_WinWidth=10
" automatically open the taglist window
let Tlist_Auto_Open=0
" exit wim when only the taglist window exist
let Tlist_Exit_OnlyWindow=1
" open tags with single click
let Tlist_Use_SingleClick=1
" close tag folds for inactive buffers
let Tlist_File_Fold_Auto_Close=1
" show the fold indicator column in the taglist window
let Tlist_Enable_Fold_Column=1
" Automatically update the taglist to include newly edited files
let Tlist_Auto_Update=1
"""""""""" NERDtree settings"""""""""""""""
" let NERDTreeWinPos='right'
"""""""""" mini buffer navigator"""""""""""
let g:miniBUfExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplUseSingleClick=1
"map <C-c> "+y
map <C-v> "+p
