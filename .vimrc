hi Normal  ctermfg=252 ctermbg=none

set nocompatible

set nu
set relativenumber
set autochdir

syntax on
set shiftwidth=4
set tabstop=4
set softtabstop=4

"xx map"
noremap J 5j
noremap K 5k
noremap H ^
noremap L $
map R :source $MYVIMRC<CR>
noremap S :w<CR>
noremap Q :q<CR>
