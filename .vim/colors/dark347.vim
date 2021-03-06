highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'dark347'
set t_Co=256
" colors 256 -> https://jonasjacek.github.io/colors/

function! s:h(group, style)
	execute "highlight" a:group
		\ "guifg="		(has_key(a:style, "guifg")		? a:style.guifg		: "NONE")
		\ "guibg="		(has_key(a:style, "guibg")		? a:style.guibg		: "NONE")
		\ "guisp="		(has_key(a:style, "guisp")		? a:style.guisp		: "NONE")
		\ "gui="		(has_key(a:style, "gui")		? a:style.gui		: "NONE")
		\ "ctermbg="	(has_key(a:style, "ctermbg")	? a:style.ctermbg	: "NONE")
		\ "ctermfg="	(has_key(a:style, "ctermfg")	? a:style.ctermfg	: "NONE")
		\ "cterm="		(has_key(a:style, "cterm")		? a:style.cterm		: "NONE")
endfunction

call s:h( 'Normal',						{ 'guibg': '#000000', 'ctermbg': 0 })
call s:h( 'Comment',					{ 'guifg': '#808080', 'ctermfg': 8, 'gui': 'italic', 'cterm': 'italic' })
call s:h( 'SpecialKey',					{ 'guifg': '#808080', 'ctermfg': 8 })
call s:h( 'LineNr',						{ 'guibg': '#121212', 'ctermbg': 233, 'guifg': 'Yellow', 'ctermfg': 11 })
call s:h( 'SignColumn',					{ 'guibg': '#121212', 'ctermbg': 233, 'guifg': 'Yellow', 'ctermfg': 233 })
" Linea de diff / git / mhinz/vim-signify
call s:h( 'SignifySignAdd', 			{ 'guibg': '#121212', 'ctermbg': 233, 'guifg': '#00ff00', 'ctermfg': 'green' })
call s:h( 'SignifySignDelete', 			{ 'guibg': '#121212', 'ctermbg': 233, 'guifg': '#ff0000', 'ctermfg': 'red' })
call s:h( 'SignifySignChange', 			{ 'guibg': '#121212', 'ctermbg': 233, 'guifg': '#ffff00', 'ctermfg': 'yellow' })
" php.vim
call s:h( 'phpUseNamespaceSeparator', 	{ 'guifg': '#ffff5f', 'ctermfg': 227 })
call s:h( 'phpDocNamespaceSeparator', 	{ 'guifg': '#ffff5f', 'ctermfg': 227 })
call s:h( 'phpClassNamespaceSeparator', { 'guifg': '#ffff5f', 'ctermfg': 227 })
call s:h( 'phpDocTags', 				{ 'guifg': '#808080', 'ctermfg': 8, 'gui': 'italic,bold', 'cterm': 'italic,bold' })
"call s:h( 'phpKeyword', 					{ 'guifg': '#a8e332', 'ctermfg': 148, 'gui': 'bold', 'cterm': 'bold' })
call s:h( 'phpClass', 					{ 'guifg': '#00af00', 'ctermfg': 34, 'gui': 'bold,underline', 'cterm': 'bold,underline' })
"call s:h( 'phpRegion', 					{ 'guifg': '#00af00', 'ctermfg': 34, 'gui': 'bold,underline', 'cterm': 'bold,underline' })
call s:h( 'phpUseClass', 				{ 'guifg': '#00af00', 'ctermfg': 34, 'gui': 'bold,underline', 'cterm': 'bold,underline' })
call s:h( 'phpStaticClasses', 			{ 'guifg': '#00af00', 'ctermfg': 34, 'gui': 'bold,underline', 'cterm': 'bold,underline' })
call s:h( 'phpFunction', 				{ 'gui': 'bold,italic', 'cterm': 'bold,italic' })
call s:h( 'phpNullValue',					{ 'guifg': '#ff0000', 'ctermfg': 'red' })

call s:h( 'phpDecorator',					{ 'guifg': '#870000', 'ctermfg': '88', 'cterm': 'italic,bold', 'gui': 'bold,italic' })
call s:h( 'phpMemberSelector',				{ 'guifg': '#ffff5f', 'ctermfg': '227', 'cterm': 'bold', 'gui': 'bold' })
call s:h( 'phpFunctions',					{ 'guifg': '#eeeeee', 'ctermfg': '231' })

"classess php, exception, etc...
"call s:h( 'phpClasses',					{ 'guifg': '#ff0000', 'ctermfg': 'red', 'cterm': 'italic', 'gui': 'italic' })

hi MGrepWindowColor         guibg=#0000ff ctermbg=blue  guifg=#000000 ctermfg=black
hi MGrepWindowNormalColor   guibg=#005f5f ctermbg=233   guifg=#ffffff ctermfg=white
hi MGrepWindowTabColor      guibg=#0000ff ctermbg=blue
hi MGrepWindowTabColorCur   guibg=#ffffff ctermbg=white 
hi MGrepMatchFileName       guibg=#000000 ctermbg=black guifg=#008000 ctermfg=green gui=italic cterm=italic
hi MGrepMatchLineNumber     guibg=#000000 ctermbg=black guifg=#0000ff ctermfg=blue  gui=italic cterm=italic
hi MGrepMatchLineNumber     guibg=#000000 ctermbg=black guifg=#ffffff ctermfg=white gui=bold cterm=bold
hi MGrepMatchWord           guibg=#ff0000 ctermbg=red   guifg=#000000 ctermfg=black

set background=dark
