autocmd BufNewFile,BufReadPost *.TODO,TODO,*.todo,*.todolist,*.taskpaper,*.tasks set filetype=plaintasks
" Detect syntax file.
autocmd BufNewFile,BufRead *.snip,*.snippets set filetype=neosnippet
" Pug
autocmd BufNewFile,BufReadPost *.pug set filetype=pug

" Jade
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
