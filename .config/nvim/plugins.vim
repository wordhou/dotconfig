call plug#begin('~/.config/nvim/plugged')

" General
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'

" Neovim
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'Shougo/denite.nvim'
Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
"Plug 'Shougo/neosnippet.vim' 
"Plug 'Shougo/neosnippet-snippets'

"  Colors
Plug 'joshdick/onedark.vim'
"Plug 'morhetz/gruvbox'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

" Latex
Plug 'lervag/vimtex'

call plug#end()

" ===== JavaScript =====
let g:javascript_conceal_arrow_function       = "⇒"
set conceallevel=1

" ===== NERDTree =====
nnoremap <leader>n :NERDTreeToggle<CR>


" ===== NeoSnippet =====
"let g:neosnippet#snippets_directory = '~/.config/nvim/neosnippets'
" conceal neosnippet markers
"set concealcursor=niv

"imap <leader>k <Plug>(neosnippet_expand_or_jump)
"smap <leader>k <Plug>(neosnippet_expand_or_jump)
"xmap <leader>k <Plug>(neosnippet_expand_target)

" ===== Coc ======
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
"autocmd! CompleteDone * if pumvisible() == 0 | pclose
"| endif

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
 " Fix autofix problem of current line
nmap <leader>cx  <Plug>(coc-fix-current)

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cn <Plug>(coc-rename)

" Use 
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)
command! -nargs=0 Format :call CocAction('format')

" ========================================

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-snippets',
  \ 'coc-stylelint',
  \ 'coc-tag',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier'
  \ ]

" ===== Denite shorcuts ===== "
"   ;        - Browser currently open buffers
"   <leader>ls - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>ls :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty -split=floating -winrow=1<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -split=floating<CR>

" ripgrep setup

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
      \   'fileformat': 'MyFileformat'
      \ },
      \ }

" ============ vimwiki ================
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
