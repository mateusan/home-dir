" Cargamos identidades

runtime! myid.vim 

if !exists("author")
	let g:author = "Autor"
	let g:email = "correo@example.com"
endif

" ABREVIATURAS
ab _comentari /*<CR><CR>*/
ab _coment /* */<ESC>hhi
ab _linea <ESC>72i*<ESC>i
ab _linea2 <ESC>72i=<ESC>i
ab _doxyfile <ESC>ddO/**<CR>*/<ESC>O@file <C-R>=expand("%:t")<CR><CR>@author <C-R>=author<CR> <mailto:<C-R>=email<CR>><CR>@brief <ESC>i 
ab _htmlscript <script language="JavaScript" type="text/javascript"><CR><!--//--><![CDATA[//><!--<CR>//--><!]]><CR></script><CR>

" Añadir cabecera doxyfile a archivos
autocmd BufNewFile *.php normal i_doxyfile 


" Entidades html
function Html_entities_replace()
	s/Á/\&Aacute;/geI
	s/É/\&Eacute;/geI
	s/Í/\&Iacute;/geI
	s/Ó/\&Oacute;/geI
	s/Ú/\&Uacute;/geI
	s/á/\&aacute;/geI
	s/é/\&eacute;/geI
	s/í/\&iacute;/geI
	s/ó/\&oacute;/geI
	s/ú/\&uacute;/geI
	s/À/\&Agrave;/geI
	s/È/\&Egrave;/geI
	s/Ì/\&Igrave;/geI
	s/Ò/\&Ograve;/geI
	s/Ù/\&Ugrave;/geI
	s/à/\&agrave;/geI
	s/è/\&egrave;/geI
	s/ì/\&igrave;/geI
	s/ò/\&ograve;/geI
	s/ù/\&ugrave;/geI
	s/Ñ/\&Ntilde;/geI
	s/ñ/\&ntilde;/geI
	s/Ü/\&Uuml;/geI
	s/ü/\&uuml;/geI
	s/Ï/\&Iuml;/geI
	s/ï/\&iuml;/geI
	:startinsert!
endfunction
function Html_entities_disreplace()
	s/&Aacute;/Á/geI
	s/&Eacute;/É/geI
	s/&Iacute;/Í/geI
	s/&Oacute;/Ó/geI
	s/&Uacute;/Ú/geI
	s/&aacute;/á/geI
	s/&eacute;/é/geI
	s/&iacute;/í/geI
	s/&oacute;/ó/geI
	s/&uacute;/ú/geI
	s/&Agrave;/À/geI
	s/&Egrave;/È/geI
	s/&Igrave;/Ì/geI
	s/&Ograve;/Ò/geI
	s/&Ugrave;/Ù/geI
	s/&agrave;/à/geI
	s/&egrave;/è/geI
	s/&igrave;/ì/geI
	s/&ograve;/ò/geI
	s/&ugrave;/ù/geI
	s/&Ntilde;/Ñ/geI
	s/&ntilde;/ñ/geI
	s/&Uuml;/Ü/geI
	s/&uuml;/ü/geI
	s/&Iuml;/Ï/geI
	s/&iuml;/ï/geI
	:startinsert!
endfunction
map ,h :call Html_entities_replace()<CR>
map ,H :call Html_entities_disreplace()<CR>

" Comentarios *****************************

" Tipo Shell
map ,#	:s/^/#/geI<CR>:nohlsearch<CR>
map ,,#	:s/^#//geI<CR>:nohlsearch<CR>
" Tipo php/c++
map ,/	:s/^/\/\//geI<CR>:nohlsearch<CR>
map ,,/	:s/^\/\///geI<CR>:nohlsearch<CR>
