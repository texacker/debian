" From" http://localhost/doc/vim/html/filetype.html#filetypes

"my filetype file
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.prolog setfiletype prolog
augroup END
