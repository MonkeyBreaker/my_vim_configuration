""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC FILE FOR MONKEY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enter the current millenium
" use vim in a modern way, not compatible with Vi
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialise vim-plug
call plug#begin('~/.vim/plugged')

" surround.vim
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" commentary.vim
" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" VIM Table Mode
" https://github.com/dhruvasagar/vim-table-mode
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }

" VIM Python Mode
" https://github.com/python-mode/python-mode
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" gen_tags.vim
" https://github.com/jsfaint/gen_tags.vim
" Disable this plugin on cygwin
if executable("ctags")
    Plug 'jsfaint/gen_tags.vim'
endif

" UltiSnips
" https://github.com/SirVer/ultisnips
Plug 'SirVer/ultisnips'

" snipMate & UltiSnip Snippets
" https://github.com/honza/vim-snippets
Plug 'honza/vim-snippets'

" vimtex
" https://github.com/lervag/vimtex
Plug 'lervag/vimtex', { 'for': 'tex' }
let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_method = 'okular'

" clang_complete
" https://github.com/xavierd/clang_complete
Plug 'xavierd/clang_complete', { 'for': ['c', 'cpp']}
if has("win32unix")
    let g:clang_library_path='/usr/bin/cygclang-5.0.dll'
else
    let g:clang_library_path='/usr/lib/llvm-6.0/lib/'
endif

" Enable the snippets-support
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'

" Buftabline
" https://github.com/ap/vim-buftabline
Plug 'ap/vim-buftabline'

" only if there are at least two buffers
let g:buftabline_show=1

" lightline.vim
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" poppy.vim
" https://github.com/bounceme/poppy.vim
Plug 'bounceme/poppy.vim'
let g:poppy_point_enable = 1

" fzf.vim
" https://github.com/junegunn/fzf.vim
Plug '/home/julian/.fzf'
Plug 'junegunn/fzf.vim'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" vim-clang-format
" https://github.com/rhysd/vim-clang-format
if executable("clang-format")
    Plug 'rhysd/vim-clang-format'
    let g:clang_format#style_options = {
                \ "IndentWidth" : 4,
                \ "UseTab" : "Never",
                \ "BreakBeforeBraces" : "Linux",
                \ "ColumnLimit" : 80,
                \ "AccessModifierOffset" : -4,
                \ "AllowShortIfStatementsOnASingleLine" : "false",
                \ "AlwaysBreakTemplateDeclarations" : "true",
                \ "Standard" : "Cpp11"}
endif

" Initialize plugin system
call plug#end()

" }}}

" Enable filetype detection, plugin and indentation enabled
filetype plugin indent on
" enable syntax and plugins (for netrw)
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMAND
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" za for using folding {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal commentstring=\"\ %s
    autocmd FileType vim setlocal colorcolumn=0
augroup END

augroup spelling
    autocmd!
    autocmd VimEnter * setlocal spelllang=en_gb
augroup END

" See https://gist.github.com/eduardocereto/3088543
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal commentstring=\#\ %s
    " By default python-mode use python2, enable python3 by default
    autocmd BufEnter,BufRead *.py let g:pymode_python = 'python3'
" 	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" 	autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" 	autocmd FileType python set foldmethod=indent foldlevel=99
"     " enable all Python syntax highlighting features
" 	autocmd FileType python let python_highlight_all = 1
" 	autocmd BufNewFile *.py 0r skeleton/skeleton.py
    autocmd FileType python setlocal colorcolumn=81
augroup END

augroup filetype_make
    autocmd!
	" Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
    autocmd FileType make setlocal commentstring=\#\ %s
augroup END

augroup filetype_c
    autocmd!
    autocmd FileType c setlocal colorcolumn=81
    autocmd FileType c setlocal commentstring=\/\/\ %s
    autocmd FileType cpp setlocal commentstring=\/\/\ %s
    autocmd FileType cpp setlocal colorcolumn=81
augroup END

augroup filetype_sh
    autocmd!
    autocmd FileType sh setlocal colorcolumn=81
    autocmd FileType sh setlocal commentstring=\#\ %s
augroup END

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal colorcolumn=0
    autocmd FileType markdown let g:markdown_folding=1
    autocmd FileType markdown let g:markdown_enable_folding=1
    autocmd FileType markdown setlocal foldmethod=manual
    autocmd FileType markdown setlocal foldcolumn=0
    autocmd FileType markdown setlocal foldlevel=3
augroup END

augroup Poppy
  au!
augroup END
" augroup surround_vim
"     autocmd!
"     autocmd FileType     let g:surround_47 = "<% \r %>"
" augroup END

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VARIABLES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if 0 == exists("commentstring")
    setlocal commentstring=\ %s
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" abbreviations in insert mode only
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iabbrev @@ monkey
iabbrev plicense MIT
iabbrev psignature <esc>:r signature.txt<cr>i
iabbrev pccopy Copyright 2019 Monkey, all rights reserved.
" Insert date in format day/month/year
iabbrev @date@ <c-r>=strftime("%d/%m/%y")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" leader key : <leader>
let mapleader = "-"

" local leader key : <localleader>
" let maplocalleader = "\\"

" enable displaying line numbers on files
set number

" when enabled displays lines as relative to the current line
" set relativenumber

" Fix default behaviour of backspace, see : https://vi.stackexchange.com/a/2163
set backspace=indent,eol,start

" Status line custom configuration
set ls=2 "Always show status line"
set statusline=%f 		" Path to the file
set statusline+=\ -\ 		" Separator
set statusline+=FileType:	" Label
set statusline+=%y 		" Filetype of the file
set statusline+=%= 		" Switch to the right side
set statusline+=%l 		" Current line
set statusline+=/ 		" Separator
set statusline+=%L 		" Total lines

" Finding files
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" autocmd filetype_make statement basically tells vim some settings to use 
" whenever it opens a Makefile. Whereas the lines below it are setting the 
" defaults.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set shiftround      " Shift to the next round tab stop.
set shiftwidth=4    " Indents will have a width of 4.

" indent when moving to the next line while writing code
set autoindent

" show the matching part of the pair for [] {} and ()
set showmatch

" Set color of the column when displayed to darkred
highlight ColorColumn ctermbg=darkred

" help adjust the default colours for better contrast
set background=dark

" 2 lines above/below cursor when scrolling
set scrolloff=2

" more natural split opening
set splitbelow
" more natural split opening
set splitright

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPING STUFF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When using mapping always use the non-recursive method => *nore*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NORMAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" use same keys as insert mode for escape
" This disable to use the "p" register !
" allow to expand recusively others <esc> without the "nore"
nmap <silent> qp <Esc>

" Move lines Up & Down
nnoremap <c-j> :let @"=col('.')<cr>:m+1<cr>==@"lh
nnoremap <c-k> :let @"=col('.')<cr>:m-2<cr>==@"lh

" Edit and sources .vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Disable because now plugin surround.cim is used
" Surround current word with double quotes, to improve with toggle "
" nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Quick correct orthography
nnoremap <c-l> 1z=<c-o>
nnoremap <F7> :setlocal spell!<cr>h 

" Disable because now plugin commentary is used
" Comment current line
" nnoremap <leader>c 0"=commentstring<c-m>P

" Go to next parathese, delete content and put in insert mode
nnoremap <leader>8 f(vi(c

" Add a new line after/before but stay in Normal mode
nnoremap <leader>o :<c-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <leader>O :<c-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" goto midle of line
nnoremap gm :call cursor(0, len(getline('.'))/2)<CR>

" prevent jump after searching word under cursor with # and *, clear with Escape
" use 'n' or 'N' to jump to next/before 
nnoremap <silent> # :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>w?<CR>
nnoremap <silent> * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<CR>
nnoremap <silent> g# :let @/ = expand('<cword>')\|set hlsearch<CR>w?<CR>
nnoremap <silent> g* :let @/ = expand('<cword>')\|set hlsearch<CR>
nnoremap <silent> <leader><space> :noh<CR>

" unimpaired buffer mappings
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" use Ag/Rg for grep if available
if executable('rg') | set gp=rg\ -S\ --vimgrep\ --no-heading gfm=%f:%l:%c:%m,%f:%l%m,%f\ \ %l%m|
elseif executable('ag') | set gp=ag\ --nogroup\ --nocolor | endif

" grep for word under cursor
nnoremap <Leader># #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>
nnoremap <Leader>* #:sil! gr! "\b<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>

" Poppy toggle
nnoremap <silent> <leader>tp :call clearmatches() \| let g:poppy = -get(g:,'poppy',-1) \|
      \ exe 'au! Poppy CursorMoved *' . (g:poppy > 0 ? ' call PoppyInit()' : '') <cr>

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" INSERT 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" This is useful for training purpose only, to train your brain to use the correct shortcut
" inoremap <esc> <nop>
inoremap qp <esc>
" inoremap <c-k> <esc>ddi

" Toggle case of the word under the cursor
inoremap <c-u> <esc>lg~iwi

" Quick correct orthography
inoremap <c-l> <c-g>u<Esc>1z=a<c-g>u

" Toggle spell check
inoremap <F7> <esc>l:setlocal spell!<cr>i

" Fix Shift+Tab
inoremap <s-tab> <Esc><<i


" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" VISUAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" Disable because now plugin surround.cim is used
" Surround current selection by ""
" Possibility with less strokes way is to : c"<c-r>"" -> let you in insert mode, other option let you in normal mode
" vnoremap <leader>" xi""<esc>hp

" Disable because now plugin commentary is used
" Comment selected line(s) 
" vnoremap <leader>c :s!^!<c-r>=commentstring<cr>!<cr>

" move selected lines
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

" replace cursor to original place
vnoremap < <gv
vnoremap > >gv

" }}}

