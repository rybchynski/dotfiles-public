if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ;f <Cmd>Telescope find_files<CR>
nnoremap <silent> ;r <Cmd>Telescope live_grep<CR>
nnoremap <silent> \\ <Cmd>Telescope buffers<CR>
nnoremap <silent> ;; <Cmd>Telescope help_tags<CR>

" Find files using Telescope command-line sugar.
nnoremap <silent> <leader>;f :DashboardFindFile<CR>
nnoremap <silent> <leader>;r :Telescope live_grep<cr>
nnoremap <silent> <leader>\\ :Telescope buffers<cr>
nnoremap <silent> <leader>;; :Telescope help_tags<cr>
nnoremap <silent> <leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <leader>fc :DashboardChangeColorscheme<CR>
nnoremap <silent> <leader>fw :DashboardFindWord<CR>
nnoremap <silent> <leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <leader>fn :DashboardNewFile<CR>nmap <leader>fss :<C-u>SessionSave<CR>
nmap <leader>fsl :<C-u>SessionLoad<CR>let g:dashboard_custom_shortcut={
      \ 'last_session'       : '<Leader> fs l',
      \ 'find_history'       : '<Leader> f h',
      \ 'find_file'          : '<Leader> f f',
      \ 'new_file'           : '<Leader> f n',
      \ 'change_colorscheme' : '<Leader> f c',
      \ 'find_word'          : '<Leader> f w',
      \ 'book_marks'         : '<Leader> f b',
      \ }

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

