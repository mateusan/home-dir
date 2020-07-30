" ==================================
" FUNCIONES GENERALES
"===================================
"
" Ejemplo:
" http://code.google.com/p/appfusedjango/source/browse/trunk/myvim/.vimrc
" http://www.ibm.com/developerworks/ssa/linux/library/l-vim-script-1/
" http://www.ibm.com/developerworks/ssa/linux/library/l-vim-script-2/
"

" Autmentar / Disminuir espacio tabs
nmap <silent> >> :let &tabstop += 1<CR>
nmap <silent> << :let &tabstop -= &tabstop > 1 ? 1 : 0<CR>

" Cambia a modo ejecutable los archivos que empiezan por #!
function ModeChange()
	if getline(1) =~ "^#!"
		silent !chmod a+x <afile>
	endif
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

" lenguage por defecto
language es_ES.utf8
language messages es_ES.utf8
language ctype es_ES.utf8
language time es_ES.utf8

"===================================
" GENERAL
"===================================

" Activar el modo de no compatibilidad con Vi
set nocompatible
" Terminal rápido
set ttyfast
" Evita los beeps en caso de error
set noerrorbells
" Evita las advertencias visuales en caso de error
set novisualbell
" Idioma para la ayuda y los mensaje
set helplang=es
" Tamaño del historial de comandos
set history=50
" Activa el uso del raton 
"set mouse=a
" Formato de copiado de portapales de X11 (botón central);
set clipboard=autoselect
" Número de tabs máximo
set tabpagemax=100

"===================================
" VISUALIZACION
"===================================

" Activa el mostrar el número de linea/columna en el inferior
set ruler
" Activa el mostrar los números de linea
set number
" Activa la indicación del modo
set showmode
" Activa la indicación de comadnos
set showcmd
" Activa el coloreado de sintaxis
syntax enable
" Cuando se cierrar parentesis, llaves, corchetes, etc. muestra su pareja (sm)
set showmatch
" Muestra el titulo del archivo
set title
" Mostrar barra de status
"set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline+=%= "indent to right

" Background es oscuro
set background=dark

" Ponemos los colores oscuros a la linea de números
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
" Pones background en línea  debajo del cursor
"set cursorline
"highlight CursorLine term=NONE cterm=bold ctermfg=NONE ctermbg=cyan gui=NONE guifg=NONE guibg=NONE


"===================================
" TABULACIONES
"===================================

" Tamaño de la tabulación (ts), 3 caracteres
set tabstop=3
" Tamaño para los sangrados, igual que ts (tw)
set shiftwidth=3
" Tamaño del ancho de linea
set textwidth=0
" No cambiar de lina automÃ¡ticamente
" set nowrap
" El tabulador inserta verdaderas tabulaciones, no espacios
set noexpandtab

"===================================
" BUSQUEDAS
"===================================

" Haces búsquedas sin importar mayuscula/min, a no ser que especifiquen mayúsculas
set ignorecase smartcase
" Busqueda incremental
set incsearch
" Iluminar todas las aparciciones de la cadena buscar
set hlsearch


"===================================
" IDENTACION 
"===================================

" Autoindentación (ai)
set autoindent
" Identación tipo c (mejor usar smartident)
set cindent
" SmartIndent
"set smartindent


"===================================
" AUTOCOMANDOS
"===================================

" En caso de comandos tipo :make, :next, habilitamos el autoguardado
" set autowrite
" Habilitamos la autdetección del tipo de lenguaje
"if has("autocmd")
"	if !exists("autocommands_loaded")
"     	let autocommands_loaded = 1
"		filetype plugin on
"		" Cuando se edite un archivo saltar a la posición donde quedamos la última vez
"		:autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
"	endif
"endif
" Some Debian-specific things
"augroup filetype
"  au BufRead reportbug.*		set ft=mail
"  au BufRead reportbug-*		set ft=mail
"augroup END

set viminfo="NONE"

"===================================
" COPIAS DE SEGURIDAD 
"===================================

" No hacer copia de seguridad
set nobackup
" Hacer copia de seguridad en un directorio cocreto
"set backup
"set backupdir=~/.tmp

"===================================
" PESTAÑAS
"===================================

map ,1 :tabprevious
map ,2 :tabnext
map ,t :tabnew
map ,e :tabedit
" mover a nueva pestaña
map ,w <C-W>T 
map <C-t> :tabnew<CR>
map <C-left> :tabprevious<CR>
map <C-right> :tabnext<CR>
"map <C-up> :tabnew<CR>
"map <C-down> :tabclose<CR>
noremap <C-up> <C-w>k
inoremap <C-up> <C-w>k 
noremap <C-down> <C-w>j 
inoremap <C-down> <C-w>j 

"===================================
" MACROS 
"===================================

" Tabulación inteligente
" https://searchcode.com/codesearch/raw/83004085/
if exists('g:loaded_tab_wrapper') || &cp
  finish
endif
let g:loaded_tab_wrapper = 1
inoremap <tab> <c-r>=InsertTabWrapper(1)<cr>
inoremap <S-tab> <c-r>=InsertTabWrapper(0)<cr>
" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the line.
function! InsertTabWrapper(forward)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif a:forward
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction
" InsertTabWrapper() }}}



" Cambia de modo de paste
set pastetoggle=<F2>

" Para poner un caracter de Return CTRL+V + RETURN, o CTRL+V + ESC
let @g='?[<>"]:nohla<?=_("/[<>"]:nohli");?>'
let @h='0wi//w"1yww"2yww"3y$o/**@brief Setter "3po@param "1pi o*/public function set"2pi( $"2"1pi ){$this->"kb"1pi = $"1pi;}/**@brief Gtkbetter dkb"3po@return o*/public function get"2pi(){return $this->"1pi;}'

"===================================
" TIPOS DE ARCHIVOS
"===================================

autocmd BufNewFile,BufRead *.tpl call Tpl()
autocmd BufNewFile,BufRead *.php call Php()
autocmd BufWritePost * call ModeChange()

function SintaxCorrect()
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

function PhpFunctions()
	call SintaxCorrect()
	map <F4> <ESC>o/**/<ESC>hh60a=<ESC>a<CR><ESC>60i=<ESC>lxO
	imap <F4> <ESC><F4>
	map <F3> a<!--<>--><ESC>3hi
	imap <F3> <ESC><F3>
	map <F5> a<?=_("");?><ESC>4hi
	imap <F5> <ESC><F5>
	map <F6> o/**<CR>*/<ESC>O@brief 
	imap <F6> <ESC><F6>
	map <F7> <F3>VISIBLE:<ESC>4l<F3>/VISIBLE:<ESC>F:a
	imap <F7> <ESC><F7>
	map <F8> <F3>BLOCK:<ESC>4l<F3>/BLOCK:<ESC>F:a
	imap <F8> <ESC><F8>

	map ,, <ESC>?[<>"]<CR>:nohl<CR>

	" Diccionario PHP
	" Listado de funciones
	" curl http://www.php.net/manual/en/indexes.functions.php | sed '/class="index"/!d' | grep -oP '>[^<]+</a> - .*</li>' | cut -b2- | sed 's~</a> - ~ ; ~; s~</li>$~~' > ~/.vim/php/funclist.txt 
"	set dictionary-=~/.vim/syntax/php.vim dictionary+=~/.vim/syntax/php.vim
"	set dictionary-=~/.vim/php/funclist.txt dictionary+=~/.vim/php/funclist.txt
"	set complete-=k complete+=k
	
	" Getters y Setters para código
	map ,s ByWi<CR><ESC>k<F6>Metodo para poner <CR>@param <ESC>pjj0wipublic fucntion set<ESC>lgU<space>A($<ESC>pA)<CR>{<CR>$this-><ESC>pA = $<ESC>pA;<CR>}<ESC>?brief<CR>:nohlsearch<CR>A
	map ,g ByWi<CR><ESC>k<F6>Método para obtener <CR>@return <ESC>pBgU<space>jj0wipublic fucntion get<ESC>lgU<space>A()<CR>{<CR>return $this-><ESC>pA;<CR>}<ESC>?brief<CR>:nohlsearch<CR>A
endfunction

function Php()
	call PhpFunctions()
	:set filetype=php
endfunction

function Tpl()
	call PhpFunctions()
	:set filetype=php
	:set tw=0
endfunction

" CONTROL+H para pasar a Hexadecimal o revertir
nmap <C-h> :call ToggleHex()<CR>
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

" ABREVIATURAS
ab _comentari /*<CR><CR>*/
ab _coment /* */<ESC>hhi
ab _linea <ESC>72i*<ESC>i
ab _linea2 <ESC>72i=<ESC>i
ab _doxyfile <ESC>ddO/**<CR>*/<ESC>O@file <C-R>=expand("%:t")<CR><CR>@author <C-R>=author<CR> <mailto:<C-R>=email<CR>><CR>@brief <ESC>i 
ab _htmlscript <script language="JavaScript" type="text/javascript"><CR><!--//--><![CDATA[//><!--<CR>//--><!]]><CR></script><CR>

" Añadir cabecera doxyfile a archivos
"autocmd BufNewFile *.php normal i_doxyfile 


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

"===================================
" PLUGINS
"===================================
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
" Ayuda de plug
"Plug 'junegunn/vim-plug'
" PHP vim
Plug 'stanangeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'
" Autocompletado PHP
Plug 'shawncplus/phpcomplete.vim'
" Status line
Plug 'itchyny/lightline.vim'
Plug 'Lokaltog/powerline-fonts'
" Branch de git, ayuda a lightline.vim
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'
" Comprobación de sintaxis
Plug 'vim-syntastic/syntastic'
" Plantillas de nuevos ficheros
Plug 'aperezdc/vim-template'
" NerdTree
Plug 'scrooloose/nerdtree'
" Comentarios segun tipo de fichero :Commentary
Plug 'tpope/vim-commentary'
" SLS files
Plug 'saltstack/salt-vim'
call plug#end()

" Sintastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_auto_jump = 1
map <F9> :SyntasticCheck<CR>
imap <F9> :SyntasticCheck<CR>


" Mostrar barra de status / itchyny/lightline.vim
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

" Mostrar siempre el tablien
set showtabline=2

function! LightlineFilename()
	let name = expand('%:t') !=# '' ? expand('%:p') : '[No Name]'
	return name
endfunction
function! LightlineReadonly()
	return &readonly ? 'RO ' : ''
endfunction
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction
function! MyTabsFunction()
	return '[Tabs '.tabpagenr().'/'.tabpagenr('$').']'
endfunction

" ayuda: :h g:lightline, filename/relativepath/absolute
let g:lightline = {
	\ 	'colorscheme': 'molokai',
	\	'separator': { 'left': "", 'right': "|" },
	\	'subseparator': { 'left': "", 'right': "|" },
	\	'active': {
	\		'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
	\		'right': [ [ 'lineinfo' ],	[ 'percent' ],	[ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex'  ] ],
	\	},
	\	'tabline': {
	\ 		'left': [[ 'tabs' ]],
	\ 		'right': [[ 'mytabs', 'syntastic'  ]],
	\	},
	\	'component': {
	\		'lineinfo': ' %3l:%-2v',
	\ 		'charvaluehex': '0x%02B',
	\	},
	\	'component_type': {
	\		'syntastic': 'error',
	\	},
	\	'component_expand': {
	\		'syntastic': 'SyntasticStatuslineFlag',
	\	},
	\	'component_function': {
	\		'gitbranch': 'LightlineFugitive',
	\ 		'mytabs': 'MyTabsFunction',
	\		'readonly': 'LightlineReadonly',
	\	},
	\ }

" Syntastic can call a post-check hook, let's update lightline there
" For more information: :help syntastic-loclist-callback
function! SyntasticCheckHook(errors)
	call lightline#update()
endfunction

"Autocompletado
"filetype plugin on
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Syntax highlighting de SQL y HTML en cadenas PHP
let php_sql_query=1
let php_htmlInStrings=1
inoremap <nul> <C-x><C-o>

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab


" plantillas
let g:templates_directory=[ '~/.vim/templates/' ]
runtime! myid.vim
" g:email, g:author
