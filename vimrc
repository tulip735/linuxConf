set nocompatible              " required
filetype off                  " required

set encoding=utf-8
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
"colorscheme solarized

"set termguicolors
"colorscheme ayu
"ilet ayucolor="dark"

syntax on
set nu
set hlsearch
"set fdm=indent

"在插入模式下移动光标
inoremap <C-b> <Left>
inoremap <C-f> <Right>


"autocommand jumps to the last known position in a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
