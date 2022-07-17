" Vim plugin config
if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()


if has("nvim")
    Plug 'neovim/nvim-lspconfig'
    Plug 'epilande/vim-es2015-snippets'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'tami5/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'mlaursen/vim-react-snippets'
    Plug 'onsails/lspkind-nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'hoob3rt/lualine.nvim'
    Plug 'preservim/nerdtree'
    Plug 'cohama/lexima.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'windwp/nvim-autopairs'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'mattn/emmet-vim'
    Plug 'glepnir/dashboard-nvim'
    Plug 'easymotion/vim-easymotion'
    Plug 'mhinz/vim-signify'
    Plug 'EdenEast/nightfox.nvim'
endif

" For JS/JSX
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

