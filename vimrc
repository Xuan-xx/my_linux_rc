filetype plugin on
" 按 F5 执行当前 Python 代码"
map <F5> :call PRUN()<CR>
func! PRUN()
    exec "w"
    if &filetype == 'python'
        exec "!python3 %"
    endif
endfunc

filetype off                   "必须"

set nocompatible                " don't bother with vi compatibility "
set autoread                    " reload files when changed on disk, i.e. via `git checkout` "
set shortmess=atI   
                    
set magic                       " For regular expressions turn magic on "
set title                       " change the terminal's title "
set nobackup                    " do not keep a backup file "                                                                                           
                    
set noerrorbells                " don't beep "
set visualbell t_vb=            " turn off error beep/flash "
set t_vb=           
set timeoutlen=500

set encoding=utf-8  
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformats=unix,dos,mac  
set termencoding=utf-8                                                                                                                                     
set formatoptions+=m
set formatoptions+=B

set ruler                       " show the current row and column "
set relativenumber                      " show line numbers "
set showcmd                     " display incomplete commands "                                                                                          
set showmode                    " display current modes "
set showmatch                   " jump to matches when entering parentheses "
set matchtime=2                 " tenths of a second to show the matching parenthesis 
set wildmenu
set wrap
set nu

set expandtab                   " expand tabs to spaces "
set smarttab        
set shiftround"

set autoindent smartindent shiftround                                                                                                                      
set shiftwidth=4    
set tabstop=4       
set softtabstop=4                " insert mode tab and backspace use 4 spaces "

"search set"
set hlsearch
set smartcase
set ignorecase

"set nocuc"
set cursorline
set tags=./.tags;,.tags


"xx map"
noremap J 5j
noremap K 5k
map R :source $MYVIMRC<CR>
noremap S :w<CR>
noremap Q :q<CR>
noremap <leader>l :vsplit<CR>
noremap <leader>j :split<CR>




"设置包括vundle和初始化相关的运行时路径"
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"启用vundle管理插件，必须"
"Plugin 'VundleVim/Vundle.vim'
"在此增加其他插件，安装的插件需要放在vundle#begin和vundle#end之间"
"安装github上的插件格式为 Plugin '用户名/插件仓库名'"
"Plugin 'davidhalter/jedi-vim'
"call vundle#end()              
"filetype plugin indent on      "加载vim自带和插件相应的语法和文件类型相关脚本，必须"

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'skywind3000/asyncrun.vim'
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F12 打开/关闭 Quickfix 窗口
" 设置 F9 编译文件
" 设置 F5运行文件
nnoremap<F12> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

Plug 'dense-analysis/ale'
let g:ale_linters = {
\   'c++': ['gcc'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\}
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'

let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
nnoremap<c-p> :LeaderfFunction!<cr> "print funtion list"
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-h>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

Plug 'vim-scripts/taglist.vim'
map <c-l> :TlistToggle<cr>  "print tag list"

Plug 'ludovicchabant/vim-gutentags'
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

call plug#end()


color snazzy

