" Root config file
set mouse=a
set encoding=utf-8
set number
set noswapfile
set scrolloff=10
set modifiable

set title
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix
set cursorline
set shell=zsh
set ignorecase 
set smarttab
filetype plugin indent on
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

if exists("&termguicolors") && exists("&winblend")
	syntax enable
	set termguicolors
" colorscheme Gruvbox
 colorscheme onedark
" colorscheme nord
" colorscheme palenight
"  colorscheme NeoSolarized 
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

" Emmet " {{{
" ---------------------------------------------------------------------
let g:user_emmet_mode='in'
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-K>'
autocmd FileType html,css,vue,ts,js,jsx,tsx,javascriptreact EmmetInstall

" }}}
" Dashboard " {{{
" ---------------------------------------------------------------------
let g:dashboard_default_executive ='telescope' 
" }}}

" signify plugin 
set updatetime=100

