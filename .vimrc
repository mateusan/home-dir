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
"nmap <silent> >> :let &tabstop += 1<CR>
"nmap <silent> << :let &tabstop -= &tabstop > 1 ? 1 : 0<CR>

runtime! functions.vim

"===================================
" GENERAL
"===================================

" lenguage por defecto
language es_ES.utf8
language messages es_ES.utf8
language ctype es_ES.utf8
language time es_ES.utf8

" leader configurable
let mapleader=" "

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

" el terminal nuevo siempre a la derecha y abajo
set splitright
set splitbelow

"===================================
" VISUALIZACION
"===================================

" Activa el mostrar el número de linea/columna en el inferior
set ruler
" Activa el mostrar los números de linea
set number
"set relativenumber
" Activa la indicación del modo
set showmode
" Activa la indicación de comadnos
set showcmd
" Activa el coloreado de sintaxis
syntax enable
syntax sync minlines=20000
" Cuando se cierrar parentesis, llaves, corchetes, etc. muestra su pareja (sm)
set showmatch
" Muestra el titulo del archivo
set title
" Background es oscuro
set background=dark

"===================================
" TABULACIONES
"===================================

" Tamaño de la tabulación (ts), 4 caracteres
set tabstop=4
" Tamaño para los sangrados, igual que ts (tw)
set shiftwidth=4
" Tamaño del ancho de linea
set textwidth=0
" No cambiar de lina automÃ¡ticamente
" set nowrap
" El tabulador inserta verdaderas tabulaciones, no espacios
set noexpandtab
"set expandtab

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
" COPIAS DE SEGURIDAD 
"===================================

set viminfo="NONE"
" No hacer copia de seguridad
set nobackup
" Hacer copia de seguridad en un directorio cocreto
"set backup
"set backupdir=~/.tmp

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
 
" PHP vim, el primera esta en el polyglot
"Plug 'stanangeloff/php.vim'
Plug 'sheerun/vim-polyglot'
Plug '2072/PHP-Indenting-for-VIm'
" Autocompletado PHP
Plug 'shawncplus/phpcomplete.vim'

" Autocompletado mientras se escribe
Plug 'davidhalter/jedi-vim'
"Plug 'ervandew/supertab'

" Status line
Plug 'itchyny/lightline.vim'
" Branch de git, ayuda a lightline.vim
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'

" Plugin que muestra los cambios en un repo git
Plug 'mhinz/vim-signify'

" Pinta las "rayas" vertical para aliner solo "spacios"
" https://github.com/Yggdroot/indentLine
" Plug 'yggdroot/indentline'
"Plug 'nathanaelkane/vim-indent-guides'

" Comprobación de sintaxis
Plug 'vim-syntastic/syntastic'

" Scroll "bonito"
Plug 'psliwka/vim-smoothie'

" Plantillas de nuevos ficheros
Plug 'aperezdc/vim-template'

" Sistema de acceso a ficheros
"Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Comentarios segun tipo de fichero :Commentary
Plug 'tpope/vim-commentary'

" SLS files
Plug 'saltstack/salt-vim'

call plug#end()

"===================================
" PLUGINS CONFIG
"===================================

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

" Mostrar siempre el tabline
set showtabline=2

colorscheme dark347
set background=dark

set listchars=tab:\┊\ 
set list

" Mostrar los cursores
"set cursorcolumn
"set cursorline

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

" function! OpenCompletion()
"     if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
"         call feedkeys("\<C-x>\<C-o>", "n")
"     endif
" endfunction
" autocmd InsertCharPre * call OpenCompletion()

" https://gist.github.com/maxboisvert/a63e96a67d0a83d71e9f49af73e71d93
" Minimalist-TabComplete-Plugin
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun
" Minimalist-AutoCompletePop-Plugin
set completeopt=menu,menuone,noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-P>", 'n')
    end
endfun


inoremap <nul> <C-x><C-o>

"===================================
" MACROS 
"===================================

" " Tabulación inteligente
" " https://searchcode.com/codesearch/raw/83004085/
" if exists('g:loaded_tab_wrapper') || &cp
"   finish
" endif
" let g:loaded_tab_wrapper = 1
" inoremap <tab> <c-r>=InsertTabWrapper(1)<cr>
" inoremap <S-tab> <c-r>=InsertTabWrapper(0)<cr>
" " InsertTabWrapper() {{{
" " Tab completion of tags/keywords if not at the beginning of the line.
" function! InsertTabWrapper(forward)
"   let col = col('.') - 1
"   if !col || getline('.')[col - 1] !~ '\k'
"     return "\<tab>"
"   elseif a:forward
"     return "\<c-p>"
"   else
"     return "\<c-n>"
"   endif
" endfunction
" " InsertTabWrapper() }}}

"===================================
" TIPOS DE ARCHIVOS
"===================================

autocmd BufNewFile,BufRead *.tpl call Tpl()
autocmd BufNewFile,BufRead *.php call Php()
autocmd BufWritePost * call ModeChangeExec()
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

function PhpFunctions()
	call PHP_SyntaxCorrect_Abbr()
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
	:set filetype=html
	":set tw=0
endfunction


"===================================
" PESTAÑAS
"===================================

" abrir nuevo tab
noremap 		<leader>t     	 	:tabnew
"map 			<C-t>         		 :tabnew<CR>
" mover la sub-ventana a una pestaña nueva
noremap 		<leader>w 			<C-W>T
" movimiento de pestañas
map 			<C-left> 			:tabprevious<CR>
map 			<C-right> 			:tabnext<CR>
"map <C-up> :tabnew<CR>
"map <C-down> :tabclose<CR>
noremap 		<C-S-up> 			<C-w>k
inoremap 	<C-S-up> 			<C-w>k 
noremap 		<C-S-down> 			<C-w>j 
inoremap 	<C-S-down> 			<C-w>j 
noremap 		<C-S-left> 			<C-w>h 
inoremap 	<C-S-left> 			<C-w>h 
noremap 		<C-S-right> 		<C-w>l
inoremap 	<C-S-right> 		<C-w>l 


"===================================
" ABREVIATURAS
"===================================

nnoremap 	<leader><space> 	:tabnew><CR>:Files<CR>
noremap 		<leader>fs 			:Files<CR>
noremap 		<leader>hex 		:call ToggleHex()<CR>
noremap 		<leader>etohtml 	:call Html_entities_replace()<CR>
noremap 		<leader>etoutf  	:call Html_entities_disreplace()<CR>
noremap 		<C-S-i> 				<C-w>+
noremap 		<C-S-k> 				<C-w>-
noremap 		<C-S-j>				<C-w><
noremap 		<C-S-l>				<C-w>>
noremap 		<leader>term      :vert :term<CR>


" Macros de código
let @g='?[<>"]:nohla<?=_("/[<>"]:nohli");?>'
let @h='0wi//w"1yww"2yww"3y$o/**@brief Setter "3po@param "1pi o*/public function set"2pi( $"2"1pi ){$this->"kb"1pi = $"1pi;}/**@brief Gtkbetter dkb"3po@return o*/public function get"2pi(){return $this->"1pi;}'

" Cambia de modo de paste
set pastetoggle=<F2>

ab _comentari /*<CR><CR>*/
ab _coment /* */<ESC>hhi
ab _linea <ESC>72i*<ESC>i
ab _linea2 <ESC>72i=<ESC>i
ab _htmlscript <script language="JavaScript" type="text/javascript"><CR><!--//--><![CDATA[//><!--<CR>//--><!]]><CR></script><CR>

"===================================
" CARGA DE ENTORNO
"===================================

" plantillas
let g:templates_directory=[ '~/.vim/templates/' ]
runtime! myid.vim
" g:email, g:author
