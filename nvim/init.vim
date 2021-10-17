" Root config file
set mouse=a
set encoding=utf-8
set number
set noswapfile
set scrolloff=10

set title
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set cursorline
set shell=zsh
set ignorecase 
set smarttab
filetype plugin indent on
set shiftwidth=2
set tabstop=2
" Auto indent
set ai
" Smart indent
set si

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Vuejs
au BufNewFile,BufRead *.vue setf vue

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" Theme configurations.
" if exists("&termguicolors") && exists("&winblend")
"  syntax enable
"  set termguicolors
"  set winblend=0
"  set wildoptions=pum
"  set pumblend=5
"  set background=dark
  " Use NeoSolarized
"  let g:neosolarized_termtrans=1
"  runtime ./colors/NeoSolarized.vim
"  colorscheme NeoSolarized
"endif

if exists("&termguicolors") && exists("&winblend")
	syntax enable
	set termguicolors
	colorscheme gruvbox
endif
" }}}

" run python scripts with F9
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Extras "{{{
" ---------------------------------------------------------------------
set exrc

"}}}

" Ultisnips " {{{
" ---------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
" list all snippets for current filetype
let g:UltiSnipsListSnippets="<C-y>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom_snippets"]
" }}}

" Ultisnips " {{{
" ---------------------------------------------------------------------
let g:user_emmet_mode='n'
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall
" }}}
