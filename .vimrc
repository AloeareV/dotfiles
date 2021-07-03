set nocompatible
let g:polyglot_disabled = ['rust.plugin']
syntax enable
filetype plugin indent on
let g:deoplete#enable_at_startup = 1

let make_ctags = "! f () { if git show >> /dev/null 2>&1; then   cd `git rev-parse --show-toplevel`;    if ls -a | grep -q \"Cargo\\.toml\"; then       ctags --exclude=target -R *;   else       ctags -R *; fi else echo Not a git repository; fi }; f"

"deoplete autocompletion
autocmd VimEnter * call deoplete#custom#option('candidate_marks', ['A', 'S', 'D', 'F', 'G'])
inoremap <expr><C-a> deoplete#insert_candidate(0)
inoremap <expr><C-s> deoplete#insert_candidate(1)
inoremap <expr><C-d> deoplete#insert_candidate(2)
inoremap <expr><C-f> deoplete#insert_candidate(3)
inoremap <expr><C-g> deoplete#insert_candidate(4)

"ctags config
if $TERM == "alacritty"
    "Alt+g 
    nnoremap g :execute make_ctags<CR><CR>
    "Alt+a
    nnoremap a g<C-]>
    "Alt+n
    nnoremap n :tn<CR>
    "Alt+p
    nnoremap p :tp<CR>
else 
    "Alt+g
    nnoremap <M-g> :execute make_ctags<CR><CR>
    "Alt+a
    nnoremap á g<C-]>
    "Alt+n
    nnoremap î :tn<CR>
    "Alt+p
    nnoremap ð :tp<CR>
endif

set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2
set number
"set relativenumber
syntax on
"set foldmethod=syntax

function RustFormat()
    execute "normal! i "
    execute "normal! a\<BS>"
    RustFmt
endfunction

function LinCol()
    set cursorline
    set cursorcolumn
endfunction

function NoLinCol()
    set nocursorline
    set nocursorcolumn
endfunction

hi ColorColumn ctermul=black 
autocmd BufWritePre *.rs :call RustFormat()
autocmd BufReadPost *.rs :SemanticHighlight
autocmd BufWritePost *.rs :SemanticHighlight
autocmd BufEnter *.rs :SemanticHighlight
"autocmd BufWritePre *.c :ClangFormat
"autocmd BufWritePre *.h :ClangFormat
"autocmd BufWritePre *.cpp :ClangFormat
autocmd FileType * set colorcolumn=
autocmd FileType rust set colorcolumn=80
hi Folded ctermfg=Black
hi Folded ctermbg=White
hi MatchParen ctermbg=green 
autocmd WinLeave * call LinCol()
autocmd WinEnter * call NoLinCol()
autocmd CursorHold * set cursorline 
autocmd CursorHoldI * set cursorline 
autocmd CursorMoved * call NoLinCol()
autocmd CursorMovedI * call NoLinCol()
autocmd VimEnter * set updatetime=4000


set wildmode=longest,list,full
set wildmenu
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

"statusline conf
hi Blue ctermbg=Blue
hi White ctermbg=White ctermfg=Black
set statusline=
set statusline+=%F              "file path
set statusline+=\ %#Blue#%M     "is_modified
set statusline+=%#StatusLine#   "back to white
set statusline+=\ \(%%%p,%l,%c\)     "precent, line, and column
set noswapfile
set autochdir
