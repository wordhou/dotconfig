call plug#begin('~/.config/nvim/plugged')

" General
Plug 'itchyny/lightline.vim' "Lightweight status bar
Plug 'ryanoasis/vim-devicons' " Adds filetype icons to NERDTree and lightline
Plug 'fcpg/vim-waikiki'
Plug 'itchyny/calendar.vim'
Plug 'tpope/vim-fugitive' " Git integration
Plug 'liuchengxu/vista.vim' " Code outline sidebar on right

" Completion and LSP
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

"Telescope
Plug '~/projects/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Denite
" Plug 'wordhou/denite-hoogle.nvim' " Haskell - Does this work??
" Plug 'Shougo/denite.nvim'
" Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}

" Vim-Clap
Plug 'liuchengxu/vim-clap', {'do': { -> clap#installer#force_download() }}
Plug 'meck/vim-clap-hoogle'
Plug 'vn-ki/coc-clap'

"  Colors
Plug 'joshdick/onedark.vim'
Plug 'franbach/miramare'
Plug 'sainnhe/gruvbox-material'

" Language specific
Plug 'pangloss/vim-javascript' " Javascript
Plug 'leshill/vim-json' " Json
Plug 'HerringtonDarkholme/yats.vim' " Typescript
Plug 'rust-lang/rust.vim' " Rust
Plug 'lervag/vimtex' " Latex
Plug 'gabrielelana/vim-markdown' " Markdown
Plug 'neovimhaskell/haskell-vim' " Haskell

call plug#end()

" =========== Clap ================
let g:clap_layout = { 'relative': 'editor' }
nnoremap <leader>ds :Clap<CR><ESC>
nnoremap <leader>dl :Clap lines<CR><ESC>
nnoremap <leader>db :Clap buffers<CR><ESC>
nnoremap ; :Clap buffers<CR><ESC>
nnoremap <leader>dg :Clap grep2<CR>
vnoremap <leader>dg :Clap grep ++query=@visual<CR>
nnoremap <leader>df :Clap files<CR>
nnoremap <leader>dh :Clap help_tags<CR>
nnoremap <leader>dr :Clap registers<CR><ESC>
nnoremap <leader>dm :Clap marks<CR><ESC>
nnoremap <leader>dy :Clap yanks<CR><ESC>

" =========== Vista.vim ===========
nnoremap <silent><leader>v :Vista!!<CR>
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 40
nnoremap <silent><leader>s :Vista show<CR>

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" =========== Coc =================
let g:coc_global_extensions = [
  \ 'coc-highlight',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-stylelint',
  \ 'coc-rust-analyzer',
  \ 'coc-go',
  \ 'coc-clangd',
  \ 'coc-vimtex',
  \ 'coc-lua',
  \ 'coc-tag',
  \ 'coc-emoji',
  \ 'coc-java'
  \ ]

" Use <Tab> and <S-Tab> to navigate completion list, and use <Enter> or
" <Ctrl+Enter> to complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u<CR>"

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
nmap <leader>ca  <Plug>(coc-codeaction)
 " Fix autofix problem of current line
nmap <leader>cx  <Plug>(coc-fix-current)

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cn <Plug>(coc-rename)
nmap <silent> <leader>ck <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cj <Plug>(coc-diagnostic-next)

nnoremap <leader>cl :CocList<CR>
nnoremap <leader>cz :CocList diagnostics<CR>
command! -nargs=0 Format :call CocAction('format')

" ===== Denite shorcuts ===== "
" nmap ; :Denite buffer -split=floating -winrow=1<CR>
" nmap <leader>ls :Denite file/rec -split=floating -winrow=1<CR>
" nnoremap <leader>dg :<C-u>Denite grep:. -no-empty -split=floating -winrow=1<CR>
" nnoremap <leader>dj :<C-u>DeniteCursorWord grep:. -split=floating<CR>
" nnoremap <leader>ds :<C-u>Denite source -split=floating<CR>
" nnoremap <leader>dh :<C-u>Denite help -split=floating<CR>
" nnoremap <leader>dm :<C-u>Denite mark -split=floating<CR>
" nnoremap <leader>dr :<C-u>Denite register -split=floating<CR>
" 
" " ripgrep setup: Denite uses ripgrep for grep
" call denite#custom#var('file/rec', 'command',
"   \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
" call denite#custom#var('grep', 'command', ['rg'])
" " Recommended defaults for ripgrep via Denite docs
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])
" 
" " Remove date from buffer list
" call denite#custom#var('buffer', 'date_format', '')
" 
" " Denite keymappings in denite buffers
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
" nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
" nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
" nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
" nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
" nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
" nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
" nnoremap <silent><buffer><expr> q denite#do_map('quit')
" nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
" nnoremap <silent><buffer><expr> l denite#do_map('do_action', 'open_link')
" nnoremap <silent><buffer><expr> m denite#do_map('do_action', 'insert_import')
" nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select')
"             endfunction
" 
" " === fruzzy setup ===
" let g:fruzzy#usenative = 1 " use native executable
" let g:fruzzy#sortonempty = 1 " sort files by similarity to current buffer
" " tell denite to use this matcher by default for all sources
" call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

" =========== vim-lightline ===========
"function! CocCurrentFunction()
"  return get(b:, 'coc_current_function', '')
"endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'fileformat': 'MyFileformat',
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

let g:lightline.colorscheme = 'gruvbox_material'

" ============= vim-waikiki ===============
let g:waikiki_roots = ['~/vimwiki/']
let g:waikiki_default_maps = 1

" ============= vim-markdown =============
let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1

" ============ vimtex =================
let g:tex_flavor = 'latex'

" ===== JavaScript =====
let g:javascript_conceal_arrow_function       = "⇒"
set conceallevel=1
