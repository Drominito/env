set encoding=utf-8
set relativenumber
set number
syntax on set noswapfile
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set textwidth=80
set nobackup

" Tastenkürzel
inoremap " ""<left>
inoremap ' ''<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
nnoremap <C-@> :call system("wl-copy", @")<CR>

nnoremap <Up> :echo "Nutze 'k' statt ↑"<CR>
nnoremap <Down> :echo "Nutze 'j' statt ↓"<CR>
nnoremap <Left> :echo "Nutze 'h' statt ←"<CR>
nnoremap <Right> :echo "Nutze 'l' statt →"<CR>




let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugin-Manager
call plug#begin()
Plug 'lervag/vimtex', { 'tag': 'v2.15' }  " WICHTIG: Nur eine Instanz!
call plug#end()

" Filetype nach Plugins laden
filetype plugin indent on
syntax enable

" Vimtex spezifische Einstellungen
let g:vimtex_view_method = 'mupdf'  " Entweder mupdf ODER okular nutzen
" let g:vimtex_view_general_viewer = 'okular'  " Falls du okular bevorzugst
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:vimtex_compiler_method = 'latexmk'
let maplocalleader = ","
