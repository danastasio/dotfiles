set nocompatible
set noet ci pi sts=0 sw=4 ts=4 sr
set number
set backspace=indent,eol,start
set noerrorbells
set guifont=3270Medium\ Nerd\ Font
set showbreak=>>
set listchars+=eol:\ 
set autowrite
set autochdir
set mouse=a
set clipboard=unnamedplus
set foldmethod=indent
set foldlevelstart=99
set noshowmode
set encoding=UTF-8
syntax on

let g:python_recommended_style = 0
let g:rust_recommended_style = 0

" Custom Macros
let @o = ':% s/^/REPLACEME|/:% s/$/|enabled|OBSERVER/ggOEXTERNAL_OBSERVER_KEY|EXTERNAL_USER_KEY|ROW_STATUS|DATA_SOURCE_KEY€ýa:noh:% s/REPLACEME/athletic'
let @c = ':% s/^/REPLACEME,/:% s/$/,S/:% s/REPLACEME/course-'

" Key Bindings
nnoremap <C-t> :NERDTreeToggle<CR>
noremap <C-n> :set number!<CR>
nnoremap <space> za
vnoremap <space> zf
nnoremap <C-u> :UndotreeToggle<CR>
noremap <C-m> :SignatureToggle<CR>

" Fat finger proof closing vim
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> WQ ((getcmdtype() is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))

" Functions
fun! CustomSyntax()
	" add in to syntax hilighting
	syn match cppStatement /\%( in \)\|\%( in \)/
	hi link cppStatement Statement

	" add strings to syntax hilighting
	syn match cppType /\%(string\)/
	hi link cppType Type
endfu

" Auto cmds
autocmd bufenter * :call CustomSyntax()											" Set C++ syntax
autocmd filetype cpp :call CustomSyntax()										" Set C++ syntax
autocmd FileType python setlocal ts=4 sw=4 sts=0 pi ci noet sr					" Custom python formatting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" add cursorline when not in insert mode
augroup cursorLine
  autocmd!
  autocmd VimEnter * set cul
  autocmd InsertLeave * set cul
  autocmd InsertEnter * set nocul
augroup END

" fixes lag of exiting insert/visual mode
if !has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
	autocmd!
	autocmd InsertEnter * set timeoutlen=0
	autocmd InsertLeave * set timeoutlen=1000
	augroup END
endif

" Override colors
augroup vimrc
	autocmd!
	autocmd ColorScheme * highlight clear Search
		\ | highlight Search ctermbg=None ctermfg=None guibg=Grey42
	autocmd ColorScheme * highlight CocHighlightText ctermbg=None ctermfg=None guibg=Grey35
augroup END

" change cursor shape
let &t_SR = "\<Esc>[4 q"                        " replace mode, underscore
let &t_EI = "\<Esc>[2 q"                        " normal mode, block

call plug#begin('~/.config/nvim/plugged')
	" Install plugins
	Plug 'ryanoasis/vim-devicons'					" NERDTree icons
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'	" Icon colors
	Plug 'preservim/nerdtree'						" File navigation
	Plug 'vim-airline/vim-airline'					" Bottom Bar
	Plug 'vim-airline/vim-airline-themes'			" Themes
	Plug 'thaerkh/vim-indentguides'					" Indentation
	Plug 'tpope/vim-fugitive'						" 
	Plug 'airblade/vim-gitgutter'					" Git Integrations
	Plug 'xolox/vim-session'						" Save sessions
	Plug 'xolox/vim-misc'							" Dependency
	Plug 'mbbill/undotree'
	Plug 'flazz/vim-colorschemes'
	Plug 'luochen1990/rainbow'                  " bracket coloring
	Plug 'vim-scripts/visualMarks'
	Plug 'vim-scripts/vim-signature'
call plug#end()

" Plugin Configuration Options
" Airline {
	let g:airline_theme='bubblegum'				 " status bar theme
	let g:airline_mode_map = {}
	let g:airline_mode_map['ic'] = 'INSERT'
	let g:airline_mode_map['R'] = 'REPLACE'
	" display all buffers if one tab open
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#tab_nr_type = 1	" buffer/tab number
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	" how file paths are shown (they're not)
	let g:airline#extensions#tabline#fnamemod = ':t'
	let g:airline_powerline_fonts = 1			 " powerline integration
	let g:airline_theme='bubblegum'				 " status bar theme
	let g:airline#extensions#tagbar#enabled = 1	 " show where in file you are
	let g:airline#extensions#tagbar#flags = 'f'
	let g:airline#extensions#coc#enabled = 1
	let g:airline_detect_modified = 0			 " stop color change of filepath
	let g:airline_section_c = airline#section#create(["%{expand('%:p:~:h:h:t')}/%{expand('%:p:h:t')}/%{expand('%:t')}"])
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_symbols.modified = ''
" }

" Vim-Session {
	let g:session_autosave = 'yes'				" Auto save session during close
	let g:session_autosave_periodic = 5			" Auto save every 5 mins
" }

" Rainbow Brackets {
	let g:rainbow_active = 1					" rainbow brackets
" }
" Indent Guides {
	let g:indentguides_spacechar = '|'			" indent guide chars
	let g:indentguides_tabchar = '|'
" }

" Vim-Session {
	let g:session_autosave = 'yes'			" auto save session periodically
	let g:session_autosave_periodic = 1		" Auto save session
	let g:session_default_to_last = 1		" Prompt to open last session
" }

" Undo tree {
	let g:undotree_WindowLayout = 2
" }

" Vim-Colors {
	colorscheme gruvbox
	set background=dark
" }
