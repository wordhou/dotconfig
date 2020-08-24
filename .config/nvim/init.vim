" ====== BASICS ======
set nocompatible
set number                     " line numbering
set backspace=indent,eol,start " backspacing in insert mode
set history=500                " :cmdline history
set hidden                     " buffers exist without being in window
set noshowcmd
syntax on
set shortmess+=c               " disable completion messages
set signcolumn=yes

let mapleader=","

" ====== PLUGINS ======
so ~/.config/nvim/plugins.vim " in a seperate file

" ====== COLORS ======
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:onedark_terminal_italics=1
colorscheme onedark

" Searching
set ignorecase
set smartcase

" ====== INDENTATION ======
set autoindent
set smartindent
set smarttab
set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab

filetype plugin on
filetype indent on

" ====== FOLDS ======
set foldmethod=syntax
set foldnestmax=1

" ====== SCROLLING ======
set scrolloff=8

" ====== SPLITS ======
set splitbelow " new split opens below
set splitright " new split opens to right

" ====== BUFFERS ======
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>

" ====== TABS ======
nnoremap <leader>th :tabp<CR>
nnoremap <leader>tl :tabn<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabc<CR>
