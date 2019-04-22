" ====== BASICS ======
set nocompatible
set number                     " line numbering
set backspace=indent,eol,start " backspacing in insert mode
set history=500                " :cmdline history
set hidden                     " buffers exist without being in window
set noshowcmd
syntax on
set shortmess+=c               " disable completion messages

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

colorscheme onedark

" GENERAL
set signcolumn=yes

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
nmap <leader>w <C-W>
set splitbelow " new split opens below
set splitright " new split opens to right

" ====== BUFFERS ======
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>br :brewind<CR>

" ====== TABS ======
nnoremap <leader>th :tabp<CR>
nnoremap <leader>tl :tabn<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabc<CR>

" ===== SESSIONS ======

map <leader>mss :mksession! ~/.vimsessions/vim.session.1<CR>
map <leader>ms1 :mksession! ~/.vimsessions/vim.session.1<CR>
map <leader>ms2 :mksession! ~/.vimsessions/vim.session.2<CR>
map <leader>ms3 :mksession! ~/.vimsessions/vim.session.3<CR>
map <leader>ms4 :mksession! ~/.vimsessions/vim.session.4<CR>
map <leader>ms5 :mksession! ~/.vimsessions/vim.session.5<CR>
map <leader>ms6 :mksession! ~/.vimsessions/vim.session.6<CR>
map <leader>ms7 :mksession! ~/.vimsessions/vim.session.7<CR>
map <leader>ms8 :mksession! ~/.vimsessions/vim.session.8<CR>
map <leader>ms9 :mksession! ~/.vimsessions/vim.session.9<CR>
map <leader>ms0 :mksession! ~/.vimsessions/vim.session.0<CR>

map <Leader>ss :source ~/.vimsessions/vim.session.1<CR>
map <Leader>s1 :source ~/.vimsessions/vim.session.1<CR>
map <Leader>s2 :source ~/.vimsessions/vim.session.2<CR>
map <Leader>s3 :source ~/.vimsessions/vim.session.3<CR>
map <Leader>s4 :source ~/.vimsessions/vim.session.4<CR>
map <Leader>s5 :source ~/.vimsessions/vim.session.5<CR>
map <Leader>s6 :source ~/.vimsessions/vim.session.6<CR>
map <Leader>s7 :source ~/.vimsessions/vim.session.7<CR>
map <Leader>s8 :source ~/.vimsessions/vim.session.8<CR>
map <Leader>s9 :source ~/.vimsessions/vim.session.9<CR>
map <Leader>s0 :source ~/.vimsessions/vim.session.0<CR>
