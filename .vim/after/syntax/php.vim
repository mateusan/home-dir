
"hi phpThrow guifg=NONE guibg=NONE gui=NONE
"call matchadd( 'phpThrow', '^\s*#\[' )

syn match phpDecorator '#\[.\+\]' containedin=ALLBUT,phpComment
hi def link phpDecorator phpComment
