colorscheme desert256
filetype plugin indent on
filetype plugin on
set autoindent
set history=5000

set binary

set nocompatible

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

set gdefault

set foldmethod=marker

set noeol

set ignorecase
set smartcase

set number
nnoremap ` :set nonumber!<CR>

set scrolloff=2

set ffs=unix,mac,dos

set wildmenu
set wildmode=list:longest,full

set hlsearch

set hidden
let g:debuggerMiniBufExpl = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplMapTabSwitchBufs = 1
let g:miniBufExplMapCTabSwitchWindows = 0
let g:miniBufExplModSelTarget = 1
nmap <c-h> <c-w>h<c-w><Bar>
nmap <c-l> <c-w>l<c-w><Bar>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

inoremap jj <ESC> 

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Don't clobber the unnamed register when pasting over text in visual mode.
vnoremap p pgvy

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

function! Find(name)
  let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("find . -iname '*".l:_name."*' -not -name \"*.class\" -and -not -name \"*.swp\" | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (<enter>=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")
map ,f :Fi