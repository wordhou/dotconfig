call plug#begin('~/.config/nvim/plugged')

" General
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neosnippet.vim' 
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'ryanoasis/vim-devicons'

"  Colors
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

" ===== NERDTree =====
nnoremap <leader>n :NERDTreeToggle<CR>
"nnoremap <silent> <leader>c :NERDTreeFind<CR>

" ===== JavaScript =====
let g:javascript_conceal_arrow_function       = "⇒"
set conceallevel=1

" ===== NeoSnippet =====
let g:neosnippet#snippets_directory = '~/.config/nvim/neosnippets'
" conceal neosnippet markers
set concealcursor=niv

imap <leader>k <Plug>(neosnippet_expand_or_jump)
smap <leader>k <Plug>(neosnippet_expand_or_jump)
xmap <leader>k <Plug>(neosnippet_expand_target)

" DENITE AND COC KEY MAPPINGS
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

" === Denite shorcuts === "
"   db         - Browser currently open buffers
"   <leader>dr - Browse list of files in current directory
"   <leader>dg - Search current directory for occurences of given term and
"   close window if no results
"   <leader>dj - Search current directory for occurences of word under cursor
nmap <leader>db :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>dr :Denite file/rec -split=floating -winrow=1<CR>
nmap <leader>ls :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>dg :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>dj :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

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
      \   'currentfunction': 'CocCurrentFunction',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat'
      \ },
      \ }
