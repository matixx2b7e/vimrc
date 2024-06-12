" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set nobackup
set noundofile
set noswapfile
" set spell
" set spell spelllang=en_us
set nospell
set nu
filetype plugin on
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set syntax=on
set showmatch
set wrap
set clipboard=unnamed,unnamedplus

set tags=./tags;$HOME

hi SpellBad ctermfg=15 ctermbg=240
hi CocInlayHint ctermfg=7 ctermbg=240
set guifont=Fira\ Code\ Regular\ 14
set background=dark

" set pythonthreedll=python38.dll

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
" inoremap { {<cr>}<ESC><S-o>
" func SkipPair()
"     if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '}' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'"
"         return "\<ESC>la"
"     else
"         return "<TAB>"
"     endif
" endfunc
" inoremap <TAB> <c-r>=SkipPair()<CR>

autocmd FileType python map <buffer> <F9> :w<cr>:AsyncRun python3 %<cr>
" autocmd FileType python map <buffer> <M-F9> :w<cr>:copen<cr>:AsyncRun python % -m pdb<cr>
autocmd FileType java map <buffer> <F9> :w<cr>:AsyncRun javac %&&java %:r<cr>
autocmd FileType java map <buffer> <M-F9> :w<cr>:AsyncRun javac %<cr>
autocmd FileType cpp map <buffer> <F9> :w<cr>:AsyncRun g++ % -o %:r -std=c++17&&./%:r<cr>
autocmd FileType cpp map <buffer> <M-F9> :w<cr>:AsyncRun g++ % -o %:r -std=c++17 -g<cr>
autocmd FileType c map <buffer> <F9> :w<cr>:AsyncRun gcc % -o %:r -std=c17&&./%:r<cr>
autocmd FileType c map <buffer> <M-F9> :w<cr>:AsyncRun gcc % -o %:r -std=c17 -g<cr>
autocmd FileType markdown map <buffer> <F9> :w<cr>:MarkdownPreview<cr>
autocmd FileType tex map <buffer> <F9> :w<cr>

autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

nnoremap mm :Autoformat<cr>

call plug#begin('/usr/share/vim/plug')
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'lervag/vimtex',{'for': 'tex'}
" Plug 'davidhalter/jedi-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-autoformat/vim-autoformat'
" Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
" Plug 'puremourning/vimspector'
call plug#end()

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
	  \ search('\%#[]>)}''"`]', 'n') ? '<Right>' :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : search('\%#[]>)}''"`]', 'n') ? '<cr><Esc>O' : '<CR>'
" not working inoremap <silent><expr> <c-space> pumvisible() ? <Plug>(coc-float-hide) : "\<c-space>"
" not working inoremap <silent><expr> <M-z> pumvisible() ? coc#pum#cancel()  : "\<M-z>"
" nmap <silent> gd <Plug>(coc-definition)
" xmap <M-f>  <Plug>(coc-format-selected)
" nmap <M-f>  <Plug>(coc-format-selected)
" let g:coc_snippet_next = '<tab>'
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
let g:vimtex_compiler_latexrun_engines ={'_':'xelatex'}
let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_compiler_latexmk = { 
"         \ 'executable' : 'latexmk',
"         \ 'options' : [ 
" 		\	'-xelatex',
"         \   '-file-line-error',
"         \   '-synctex=1',
"         \   '-interaction=nonstopmode',
"         \ ],
"         \}
" let g:vimtex_compiler_latexmk_engines = {
"         \ 'xelatex'          : '-xelatex',
"         \ '_'                : '-pdf',
"         \ 'pdfdvi'           : '-pdfdvi',
"         \ 'pdfps'            : '-pdfps',
"         \ 'pdflatex'         : '-pdf',
"         \ 'luatex'           : '-lualatex',
"         \ 'lualatex'         : '-lualatex',
"         \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
"         \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
"         \ 'context (luatex)' : '-pdf -pdflatex=context',
"         \}

let g:mkdp_path_to_firefox = "firefox"

