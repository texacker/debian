set nu
set ruler
set nowrap
" colo blue

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" syntax on
syntax enable
" set background=dark
" colorscheme solarized

set hlsearch
set nobackup
set showcmd

" softtabstop 表示在编辑模式的时候按退格键的时候退回缩进的长度，当使用 expandtab 时特别有用。
"set sts=4

" shiftwidth 表示每一级缩进的长度，一般设置成跟 softtabstop 一样。
"set shiftwidth=4

" tabstop 表示一个 tab 显示出来是多少个空格的长度，默认 8。
set tabstop=4

" expandtab 表示缩进用空格来表示，noexpandtab 则表示用制表符表示一个缩进
" set expandtab

" 不备份
set nobackup
set nowritebackup

" 不要工具条
set guioptions-=T
set nomodeline

set tags=tags;/,codex.tags;/
