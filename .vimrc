set number
set undofile
set cursorline
syntax on

set noet 
set ci
set pi
set sts=0
set sw=4
set ts=4
set backspace=indent,eol,start

fun! CustomSyntax()
	" add in to syntax hilighting
    syn match cppStatement /\%( in \)\|\%( in \)/
    hi link cppStatement Statement

	" add strings to syntax hilighting
	syn match cppType /\%(string\)/
    hi link cppType Type

endfu
autocmd bufenter * :call CustomSyntax()
autocmd filetype * :call CustomSyntax()
