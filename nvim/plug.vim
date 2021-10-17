" Vim plugin config
if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()


if has("nvim")
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'tami5/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
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
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'octaltree/cmp-look'
    Plug 'kristijanhusak/vim-dadbod-completion'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'mattn/emmet-vim'
endif

" For JS/JSX
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

