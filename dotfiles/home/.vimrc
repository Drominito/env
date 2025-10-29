set encoding=utf-8
" set noswapfile # hmm, but why?
set shiftwidth=4
set autoindent
" set textwidth=80
set nobackup

set laststatus=2
" no --INSERT-- etc.
set noshowmode

" autocompletion 
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

nnoremap <F5> :MundoToggle<CR>

" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt=0
set completeopt=menuone,noinsert,noselect,preview

" https://github.com/itchyny/lightline.vim/issues/68
" colorscheme molokai

" https://github.com/maximbaz/lightline-ale
" 1. Register the components
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'gitstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \   'gitstatus': 'GitStatus'
      \ },
      \ }

set statusline+=%{GitStatus()}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
" 2. Set color to the components

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
" 3. add components to lightline
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }

" 3.1. Lineinfo, fileformat, etc. have to be added additionaly. Final example:
let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ] }


let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
" 
"
" It's very annoying, because i can't repeat the / search funktion with n..
" nnoremap <C-k> :suspend<CR>
" nnoremap s h
" nnoremap n j
" nnoremap r k
" nnoremap t l
" 
" vnoremap s h
" vnoremap n j
" vnoremap r k
" vnoremap t l
" 
" onoremap s h
" onoremap n j
" onoremap r k
" onoremap t l
"
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)



let mapleader=','
    if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
    endif



nnoremap <C-m> :AsyncRun octodown % <CR>

syntax enable
syntax on

" init() " for directories

let g:relative = expand("~/.vim/pack/myplugins/start/")
let g:url      = ("https://github.com/")

function! Plug(repo)
    let plugin = fnamemodify(a:repo, ":t")
    if !isdirectory(g:relative . plugin)
        execute '!git clone https://github.com/' . a:repo . ' ' . g:relative . plugin
    endif
endfunction

!clear

" call Plug("tbabej/taskwiki")
" call Plug("blindFS/vim-taskwarrior")

call Plug("junegunn/fzf.vim")
call Plug("junegunn/limelight.vim")
call Plug("vim-utils/vim-man")
call Plug("junegunn/goyo.vim")
call Plug("skywind3000/asyncrun.vim")
" call Plug("vim-airlinevim-airline")
" call Plug("ycm-core/YouCompleteMe")
call Plug("godlygeek/tabular.git")
call Plug("easymotion/vim-easymotion")
call Plug("kien/ctrlp.vim")
call Plug("preservim/nerdtree")

" git stuff
call Plug("tpope/vim-fugitive")
call Plug("rbong/vim-flog")
call Plug("airblade/vim-gitgutter")
call Plug("junegunn/gv.vim")
" call Plug("jreybert/vimagitstchars")
call Plug("bling/vim-bufferline")
call Plug("voldikss/vim-floaterm")
call Plug("")
call Plug("")
call Plug("")
highlight SignColumn guibg=black ctermbg=black
" Vim 7.4.2201
set signcolumn=yes


nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" autocomplete

" call Plug("dense-analysis/ale")
" call Plug("andreypopp/asyncomplete-ale.vim")
call Plug("mx-moth/linters.vim")
call Plug("itchyny/lightline.vim")

" call Plug("prabirshrestha/vim-lsp")
" call Plug("mattn/vim-lsp-settings")
call Plug("prabirshrestha/asyncomplete.vim")
" call Plug("yegappan/lsp")
call Plug("vim-scripts/DrawIt")
call Plug("ap/vim-buftabline")
call Plug("wellle/context.vim")
call Plug("edkolev/tmuxline.vim")
" Tmuxline lightline
call Plug("")
call Plug("")
call Plug("vim-ctrlspace/vim-ctrlspace")
" Buffer Managment
call Plug("mildred/vim-bufmru")
call Plug("")
call Plug("")


set hidden
nnoremap <C-I> :bnext<CR>
nnoremap <C-O> :bprev<CR>

" au User asyncomplete_setup call asyncomplete#ale#register_source({
"     \ 'name': 'reason',
"     \ 'linter': 'flow',
"     \ })

call Plug("tpope/vim-dispatch")
call Plug("mbbill/undotree.git")
call Plug("simnalamburt/vim-mundo") " fork of sjl/gundo that's based on undotree
call Plug("wincent/terminus")
call Plug("terryma/vim-multiple-cursors")
call Plug("")
call Plug("tpope/vim-surround")
" call Plug("tpope/vim-commentary")
call Plug("preservim/nerdcommenter")
call Plug("")
call Plug("")
call Plug("")

" ----------------------------------------------------
hi BuftabLineCurrent ctermfg=white ctermbg=blue guifg=#ffffff guibg=#005f87
hi BuftabLineActive  ctermfg=black ctermbg=cyan  guifg=#000000 guibg=#00d7ff
hi BuftabLineInactive ctermfg=grey  ctermbg=black guifg=#808080 guibg=#000000


" after these plugins (because it may be overwritten.
set relativenumber
set syntax on
" au BufRead,BufNewFile ~/.bashrc *.sh,*.bash set filetype=sh
au BufRead,BufNewFile ~/.bashrc set filetype=sh


" ----------------------------------------------------




inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)
" For Vim 8 (<c-@> corresponds to <c-space>):
" imap <c-@> <Plug>(asyncomplete_force_refresh)


" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 0

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif





set completeopt=menuone,noinsert,noselect,preview

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" lsp

" if executable('pylsp')
"     " pip install python-lsp-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pylsp',
"         \ 'cmd': {server_info->['pylsp']},
"         \ 'allowlist': ['python'],
"         \ })
" endif

" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gs <plug>(lsp-document-symbol-search)
"     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
"     nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
"     nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
" 
"     let g:lsp_format_sync_timeout = 1000
"     autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
" 
"     " refer to doc to add more commands
" endfunction
" 
" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END



" au User asyncomplete_setup call asyncomplete#ale#register_source({
"     \ 'name': 'reason',
"     \ 'linter': 'flow',
"    \ })
" set spell
" set spelllang=en_us

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


" Clangd language server
" call LspAddServer([#{
"  	\    name: 'clangd',
" 	\    filetype: ['c'],
" 	\    path: '/usr/local/bin/clangd',
" 	\    args: ['--background-index']
" 	\  }])


"call LspOptionsSet(#{
"        \   aleSupport: v:false,
"        \   autoComplete: v:true,
"        \   autoHighlight: v:false,
"        \   autoHighlightDiags: v:true,
"        \   autoPopulateDiags: v:false,
"        \   completionMatcher: 'case',
"        \   completionMatcherValue: 1,
"        \   diagSignErrorText: 'E>',
"        \   diagSignHintText: 'H>',
"        \   diagSignInfoText: 'I>',
"        \   diagSignWarningText: 'W>',
"        \   echoSignature: v:false,
"        \   hideDisabledCodeActions: v:false,
"        \   highlightDiagInline: v:true,
"        \   hoverInPreview: v:false,
"        \   ignoreMissingServer: v:false,
"        \   keepFocusInDiags: v:true,
"        \   keepFocusInReferences: v:true,
"        \   completionTextEdit: v:true,
"        \   diagVirtualTextAlign: 'above',
"        \   diagVirtualTextWrap: 'default',
"        \   noNewlineInCompletion: v:false,
"        \   omniComplete: v:null,
"        \   outlineOnRight: v:false,
"        \   outlineWinSize: 20,
"        \   popupBorder: v:true,
"        \   popupBorderHighlight: 'Title',
"        \   popupBorderHighlightPeek: 'Special',
"        \   popupBorderSignatureHelp: v:false,
"        \   popupHighlightSignatureHelp: 'Pmenu',
"        \   popupHighlight: 'Normal',
"        \   semanticHighlight: v:true,
"        \   showDiagInBalloon: v:true,
"        \   showDiagInPopup: v:true,
"        \   showDiagOnStatusLine: v:false,
"        \   showDiagWithSign: v:true,
"        \   showDiagWithVirtualText: v:false,
"        \   showInlayHints: v:false,
"        \   showSignature: v:true,
"        \   snippetSupport: v:false,
"        \   ultisnipsSupport: v:false,
"        \   useBufferCompletion: v:false,
"        \   usePopupInCodeAction: v:false,
"        \   useQuickfixForLocations: v:false,
"        \   vsnipSupport: v:false,
"        \   bufferCompletionTimeout: 100,
"        \   customCompletionKinds: v:false,
"        \   completionKinds: {},
"        \   filterCompletionDuplicates: v:false,
"        \   condensedCompletionMenu: v:false,

let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

"let lspServers = [#{
"	\	  name: 'clang',
"	\	  filetype: ['c'],
"	\	  path: '/usr/local/bin/clangd',
"	\	  args: ['--background-index']
"	\ }]
"autocmd User LspSetup call LspAddServer(lspServers)


nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>


" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1



" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" 
autocmd! User GoEnter 'set number'

" Limelight " Focus at note taking


" centers the current pane as the middle 2 of 4 imaginary columns
" should be called in a window with a single pane

 function CenterPane()
   lefta vnew
   wincmd w
   exec 'vertical resize '. string(&columns * 0.75)
 endfunction

" optionally map it to a key:
" nnoremap <leader>c :call CenterPane()<cr>



" GOYO + Limelight Config
" https://github.com/junegunn/goyo.vim/issues/191
"-----------------------------------------------------------------
" I dont like it. I would have relativenumbers next to the text.
" That it is so narrow, it could be a benefit because of -
" 	- Writing well thought-out text
"	- Would fit in small 13.3inch e-ink Monitors.

" let g:goyo_width = 85
" let g:goyo_linenr=0
" function! s:goyo_enter()
"     call s:disable_autonumber() 
"     " set nocursorcolumn nocursorline
"     set nonumber
"     let g:undotree_CustomUndotreeCmd = 'leftabove vertical 32 new'
"     let g:undotree_CustomDiffpanelCmd = 'belowright 12 new'
"     Limelight
" endfunction
" function! s:goyo_leave()
"     call s:enable_autonumber()
"     set cursorcolumn cursorline
"     set number
"     set relativenumber " my
"     unlet g:undotree_CustomUndotreeCmd
"     unlet g:undotree_CustomDiffpanelCmd
"     Limelight!
" endfunction
" augroup rn_distraction_free
"     au!
"     " autocmd! User GoyoEnter nested call <SID>goyo_enter()
"     " autocmd! User GoyoLeave nested call <SID>goyo_leave()
" augroup END
" 
" " hybrid (auto-switching) line numbers - see https://jeffkreeftmeijer.com/vim-number/
" function! s:disable_autonumber()
"     au! rn_autonumber
" endfunction
" function! s:enable_autonumber()
"     augroup rn_autonumber
"         au!
"         au BufEnter,FocusGained,InsertLeave * set norelativenumber
"         au BufLeave,FocusLost,InsertEnter   * set relativenumber
"     augroup END
" endfunction
" set number
" call s:enable_autonumber()
" 


" 
" 
" 
" 
" 
" nnoremap <buffer> A       ... " add annotation
" nnoremap <buffer> x       ... " delete annotation.
" nnoremap <buffer> o       ... " open the annotation as a file.
" nnoremap <buffer> a       ... " create new task.
" nnoremap <buffer> d       ... " set the task in current line done.
" nnoremap <buffer> D       ... " delete task
" nnoremap <buffer> <Del>   ... " delete field/annotation/task
" nnoremap <buffer> <Space> ... " select/remove current task to selected list
" nnoremap <buffer> m       ... " modify current field.
" nnoremap <buffer> M       ... " modify current task.
" nnoremap <buffer> f       ... " change filter
" nnoremap <buffer> r       ... " change report type
" nnoremap <buffer> c       ... " execute a command for selected tasks/current task
" nnoremap <buffer> R       ... " refresh the report/clear selected list
" nnoremap <buffer> q       ... " quit buffer.
" nnoremap <buffer> X       ... " clear all completed task.
" nnoremap <buffer> p       ... " duplicate selected tasks
" nnoremap <buffer> u       ... " undo last change.
" nnoremap <buffer> +       ... " start task
" nnoremap <buffer> -       ... " stop task
" nnoremap <buffer> S       ... " sync with taskd server.
" nnoremap <buffer> s       ... " sort by this column primarily.(if already of the highest priority then switch the polarity)
" nnoremap <buffer> <       ... " sort by this column increasingly.(if already increasingly then increase its priority)
" nnoremap <buffer> >       ... " sort by this column decreasingly.(if already decreasingly then decrease its priority)
" nnoremap <buffer> H       ... " cycle column format left
" nnoremap <buffer> L       ... " cycle column format right
" nnoremap <buffer> J       ... " next historical entry
" nnoremap <buffer> K       ... " previous historical entry
" nnoremap <buffer> B       ... " create a bookmark for current combination
" nnoremap <buffer> <F1>    ... " view the documents
" nnoremap <buffer> <CR>    ... " show task info.
" nnoremap <buffer> <TAB>   ... " jump to the next column
" nnoremap <buffer> <S-TAB> ... " jump to the previous column
" nnoremap <buffer> <right> ... " jump to the next non-empty column
" nnoremap <buffer> <left>  ... " jump to the previous non-empty column
" vnoremap <buffer> d       ... " set done to all visual selected tasks
" vnoremap <buffer> D       ... " delete all visual selected tasks
" vnoremap <buffer> <CR>    ... " show information about visual selected tasks
" vnoremap <buffer> <Space> ... " add visual selected tasks to selected list
" 
" 
" " default task report type
" let g:task_report_name     = 'next'
" " custom reports have to be listed explicitly to make them available
" let g:task_report_command  = []
" " whether the field under the cursor is highlighted
" let g:task_highlight_field = 1
" " can not make change to task data when set to 1
" let g:task_readonly        = 0
" " vim built-in term for task undo in gvim
" let g:task_gui_term        = 1
" " allows user to override task configurations. Seperated by space. Defaults to ''
" let g:task_rc_override     = 'rc.defaultwidth=999'
" " default fields to ask when adding a new task
" let g:task_default_prompt  = ['due', 'description']
" " whether the info window is splited vertically
" let g:task_info_vsplit     = 0
" " info window size
" let g:task_info_size       = 15
" " info window position
" let g:task_info_position   = 'belowright'
" " directory to store log files defaults to taskwarrior data.location
" let g:task_log_directory   = '~/.task'
" " max number of historical entries
" let g:task_log_max         = '20'
" " forward arrow shown on statusline
" let g:task_left_arrow      = ' <<'
" " backward arrow ...
" let g:task_left_arrow      = '>> '
" 
" 
" highlight default link taskwarrior_tablehead   Tabline
" highlight default link taskwarrior_field       IncSearch
" highlight default link taskwarrior_selected    Visual
" highlight default link taskwarrior_id          VarId
" highlight default link taskwarrior_project     String
" highlight default link taskwarrior_Status      Include
" highlight default link taskwarrior_priority    Class
" highlight default link taskwarrior_due         Todo
" highlight default link taskwarrior_end         Keyword
" highlight default link taskwarrior_description Normal
" highlight default link taskwarrior_entry       Special
" highlight default link taskwarrior_depends     Todo
" highlight default link taskwarrior_tags        Keyword
" highlight default link taskwarrior_uuid        VarId
" highlight default link taskwarrior_urgency     Todo

autocmd VimEnter *.md Goyo



" Maybe later, i have no idea of vimscript.
" let g:autosave_time = 10 " Zeit in Sekunden
" let b:save_time = localtime()
" 
" function! UpdateFile()
"   if (localtime() - b:save_time) >= g:autosave_time
"     update
"     let b:save_time = localtime()
"   endif
" endfunction
" 
" au CursorHold * call UpdateFile()
" 



set noexpandtab
set smarttab
set tabstop=4
set shiftwidth=4

