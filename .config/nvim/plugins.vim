call plug#begin('~/.config/nvim/plugged')

" Utility
Plug 'scrooloose/nerdtree' " File browser tree sidebar on left
Plug 'itchyny/lightline.vim' "Lightweight status bar
Plug 'ryanoasis/vim-devicons' " Adds filetype icons to NERDTree and lightline
Plug 'vimwiki/vimwiki' " Personal journal
Plug 'tpope/vim-fugitive' " Git integration
Plug 'liuchengxu/vista.vim' " Code outline sidebar on right

" Major
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Denite
Plug 'Shougo/denite.nvim'
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}

"  Colors
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'

" Rust
Plug 'rust-lang/rust.vim'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

" Latex
Plug 'lervag/vimtex'

call plug#end()

" =========== NERDTree ============
nnoremap <leader>n :NERDTreeToggle<CR>

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
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-stylelint',
  \ 'coc-tag',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-emoji',
  \ 'coc-rust-analyzer',
  \ 'coc-go'
  \ ]

" Use <Tab> and <S-Tab> to navigate completion list, and use <Enter> or
" <Ctrl+Enter> to complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u<CR>"
" This adds a <Ctrl+Enter> completion option since vimwiki takes over the <CR>
inoremap <expr> <NL> pumvisible() ? "\<C-y>" : "\<C-g>u<CR>"

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
nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>ls :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>dg :<C-u>Denite grep:. -no-empty -split=floating -winrow=1<CR>
nnoremap <leader>dj :<C-u>DeniteCursorWord grep:. -split=floating<CR>
nnoremap <leader>ds :<C-u>Denite source -split=floating<CR>
nnoremap <leader>dh :<C-u>Denite help -split=floating<CR>
nnoremap <leader>dm :<C-u>Denite mark -split=floating<CR>
nnoremap <leader>dr :<C-u>Denite register -split=floating<CR>

" ripgrep setup: Denite uses ripgrep for grep
call denite#custom#var('file/rec', 'command',
  \ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
call denite#custom#var('grep', 'command', ['rg'])
" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Denite keymappings in denite buffers
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
nnoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action')
nnoremap <silent><buffer><expr> d
      \ denite#do_map('do_action', 'delete')
nnoremap <silent><buffer><expr> p
      \ denite#do_map('do_action', 'preview')
nnoremap <silent><buffer><expr> s
      \ denite#do_map('do_action', 'split')
nnoremap <silent><buffer><expr> v
      \ denite#do_map('do_action', 'vsplit')
nnoremap <silent><buffer><expr> <Esc>
      \ denite#do_map('quit')
nnoremap <silent><buffer><expr> i
      \ denite#do_map('open_filter_buffer')
nnoremap <silent><buffer><expr> <Space>
      \ denite#do_map('toggle_select')
            endfunction

" === fruzzy setup ===
let g:fruzzy#usenative = 1
" When there's no input, fruzzy can sort entries based on how similar they are
" to the current buffer
" " For ex: if you're on /path/to/somefile.h, then on opening denite,
" /path/to/somefile.cpp
" would appear on the top of the list.
" Useful if you're bouncing a lot between similar files.
" To turn off this behavior, set the variable below  to 0
let g:fruzzy#sortonempty = 1 " default value
" tell denite to use this matcher by default for all sources
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

" =========== vim-lightline ===========
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

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

" ============ vimwiki ================
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0 " Only assigns vimwiki filetype to .md files in the vimwiki path
let g:vimwiki_table_mappings=0 " Disables table mappings, freeing <TAB> for tab completion (coc)
let g:vimwiki_markdown_link_ext = 1 " Adds .md to links

" ============ vimtex =================
let g:tex_flavor = 'latex'

" ===== JavaScript =====
let g:javascript_conceal_arrow_function       = "⇒"
set conceallevel=1
