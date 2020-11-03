
"===================================
" FUNCIONES
"===================================

" Cambia a modo ejecutable los archivos que empiezan por #!
function ModeChangeExec()
	if getline(1) =~ "^#!"
		silent !chmod a+x <afile>
	endif
endfunction

" Corrección de
function PHP_SyntaxCorrect_Abbr()
	ab fnction function
	ab fucntio function
	ab fucntiio function
	ab fucntion function
	ab functin function
	ab functio function
	ab funtion function
	ab retrun return
	ab pulbic public
	ab publci public
	ab parma param
	ab prama param
endfunction

" Condificar a UTF/Unix
function! F_CodificaUTF()
	set fileformat=unix
	set encoding=utf8
	set fileencoding=utf8
	set filetype=utf8
	set nobomb
endfunction
command! -nargs=0 -bar ToUTF call F_CodificaUTF()
ToUTF

" Entidades UTF a html
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

" Pasar a hexadecimail <leader>hex
let g:hexbasti = 0
function! ToggleHex()
  if g:hexbasti == 0
    let g:hexbasti = 1
    syntax off
    execute ":%!xxd"
  elseif g:hexbasti == 1
    let g:hexbasti = 0
    syntax on
    execute ":%!xxd -r"
  endif
endfunction

"Here's a mapping that will show the hierarchy of the synstack() and also show the highlight links. press gm to use it. 
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map gm :call SynStack()<CR>
