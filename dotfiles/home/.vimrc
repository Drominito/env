" ============================================================================
" GRUNDLEGENDE EINSTELLUNGEN
" ============================================================================

set encoding=utf-8
set shiftwidth=4
set tabstop=4
set smarttab
set noexpandtab
set autoindent
set nobackup
set noswapfile
set hidden
set laststatus=2
set noshowmode
set signcolumn=yes
set relativenumber
set number
syntax enable
syntax on

" Undo-Verzeichnis für persistente Undo-History
if has("persistent_undo")
    let target_path = expand('~/.undodir')
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir = target_path
    set undofile
endif

" ============================================================================
" TASTENZUORDNUNGEN (MAPPINGS)
" ============================================================================

let mapleader=','

" Buffer Navigation
nnoremap <C-I> :bnext<CR>
nnoremap <C-O> :bprev<CR>

" Plugin Toggles
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <F5> :MundoToggle<CR>

" Autosave Timer
let g:autosave_timer = 0
function! AutoSaveTimer()
    if g:autosave_timer
        call timer_stop(g:autosave_timer)
    endif
    let g:autosave_timer = timer_start(5000, 'AutoSaveFile')
endfunction

function! AutoSaveFile(timer_id)
    silent! update
endfunction

autocmd CursorHold,CursorHoldI,TextChanged,TextChangedI * call AutoSaveTimer()

" ============================================================================
" PLUGIN-MANAGEMENT (Einfache Installation)
" ============================================================================

let g:relative = expand("~/.vim/pack/myplugins/start/")

function! Plug(repo)
    let plugin = fnamemodify(a:repo, ":t")
    if !isdirectory(g:relative . plugin)
        execute '!git clone https://github.com/' . a:repo . ' ' . g:relative . plugin
    endif
endfunction


" ============================================================================
" PLUGIN-LISTE
" ============================================================================

call Plug("dmix/elvish.vim")

" Datei-Explorer & Navigation
call Plug("preservim/nerdtree")
call Plug("junegunn/fzf.vim")
call Plug("kien/ctrlp.vim")
call Plug("easymotion/vim-easymotion")

" Git Integration
call Plug("tpope/vim-fugitive")
call Plug("rbong/vim-flog")
call Plug("airblade/vim-gitgutter")
call Plug("junegunn/gv.vim")

" UI & Statusleiste
call Plug("itchyny/lightline.vim")
call Plug("bling/vim-bufferline")
call Plug("ap/vim-buftabline")
call Plug("edkolev/tmuxline.vim")

" Textbearbeitung
call Plug("tpope/vim-surround")
call Plug("preservim/nerdcommenter")
call Plug("godlygeek/tabular")
call Plug("terryma/vim-multiple-cursors")

" Terminal & Ausführung
call Plug("skywind3000/asyncrun.vim")
call Plug("voldikss/vim-floaterm")

" Undo & History
call Plug("mbbill/undotree")
call Plug("simnalamburt/vim-mundo")

" Focus & Writing
call Plug("junegunn/goyo.vim")
call Plug("junegunn/limelight.vim")

" Buffer Management
call Plug("vim-ctrlspace/vim-ctrlspace")
call Plug("mildred/vim-bufmru")

" Verschiedenes
call Plug("vim-scripts/DrawIt")
call Plug("wellle/context.vim")
call Plug("danielwe/vim-butter")

" ============================================================================
" PLUGIN-KONFIGURATIONEN
" ============================================================================

" --- Lightline (Statusleiste) ---
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
      \              [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'gitstatus': 'GitStatus'
      \ },
      \ }

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" --- GitGutter (Git Änderungen) ---
highlight SignColumn guibg=black ctermbg=black
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

" --- EasyMotion (Schnelle Navigation) ---
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" --- Tabular (Textausrichtung) ---
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" --- Limelight (Fokus-Modus) ---
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

" --- Floating Terminal ---
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" --- AsyncRun ---
nnoremap <C-m> :AsyncRun octodown % <CR>

" ============================================================================
" AUTOCOMMANDS
" ============================================================================

" Automatisches Speichern
autocmd InsertLeave,TextChanged,TextChangedI * silent! update

" Filetype-spezifische Einstellungen
au BufRead,BufNewFile ~/.bashrc set filetype=sh

" Goyo + Limelight für Markdown
autocmd VimEnter *.md Goyo
autocmd! User GoyoEnter nested set relativenumber number

" ============================================================================
" FARBEN & HIGHLIGHTING
" ============================================================================

" Bufferline Farben
hi BuftabLineCurrent ctermfg=white ctermbg=blue guifg=#ffffff guibg=#005f87
hi BuftabLineActive  ctermfg=black ctermbg=cyan  guifg=#000000 guibg=#00d7ff
hi BuftabLineInactive ctermfg=grey  ctermbg=black guifg=#808080 guibg=#000000

" ============================================================================
" ENTFERNE UNGENUTZTE/INAKTIVE KONFIGURATION
" ============================================================================

" Folgendes wurde auskommentiert oder ist inaktiv:

" set textwidth=80                    " Zeilenumbruch bei 80 Zeichen
" call Plug("dense-analysis/ale")     " Linter Plugin
" call Plug("prabirshrestha/vim-lsp") " LSP Client
" set spell                          " Rechtschreibprüfung
" colorscheme molokai                " Farbschema

" ============================================================================
" HINWEIS FUR ZUKÜNFTIGE PFLEGE
" ============================================================================

" 1. Plugins werden in ~/.vim/pack/myplugins/start/ installiert
" 2. Leader-Taste ist das Komma (,)
" 3. Wichtige Shortcuts:
"    - Ctrl+t: NERDTree ein/aus
"    - F5: Undo History (Mundo)
"    - F7-F12: Floating Terminal
"    - ,f: EasyMotion nach Buchstaben
"    - ,w: EasyMotion nach Wörtern
"    - ,L: EasyMotion nach Zeilen
"    - ]c/[c: Git Hunk Navigation
"    ,hs/,hu: Git Hunk Stage/Undo
