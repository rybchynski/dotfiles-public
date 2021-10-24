" maps for nvim.
inoremap jk <esc>
let mapleader = ','

" --------------------------------------------------------
" goto next/prev buffer.
map gn :bn<cr>
map gp :bp<cr>
map gw :Bclose<cr>
map gW :Bclose!<cr>
nnoremap U <C-R>

nmap <Leader><space> :nohlsearch<cr>

" --------------------------------------------------------
" Easymotion
map ; <Plug>(easymotion-prefix)
map ;st <Plug>(easymotion-s2)
map ;. <Plug>(easymotion-repeat)

" --------------------------------------------------------
" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" C-w + w -- toggle focus @see maps below (windows section)
" C-w + h/j/k/l -- the same

" --------------------------------------------------------
" copy to the main clipboard
" "*y -> "*p to paste from;

" --------------------------------------------------------
" Delete without yank
nnoremap x "_x

" --------------------------------------------------------
" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" --------------------------------------------------------
" Delete a word backwards (using with w + dw)
" nnoremap dw vb"_d

" --------------------------------------------------------
" Select all
nmap <C-a> gg<S-v>G

" --------------------------------------------------------
"  Tabs

" Open current directory
nmap te :tabedit
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

" --------------------------------------------------------
"  Windows

"Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

