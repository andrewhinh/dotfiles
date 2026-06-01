set autoindent
set indentexpr=off
set expandtab
set tabstop=4

set sw=4
set textwidth=80
set nohls
set noshowmatch
syntax enable
set nospell
set background=dark
autocmd VimEnter * set vb t_vb=

set modeline
set nojoinspaces " pesky 2-spaces after the period thing

set nowritebackup
set noswapfile
set nobackup

" don't delete whitespace-only lines leaving insert mode:
inoremap <CR> x<BS><CR>x<BS>
inoremap <up> x<BS><up>
inoremap <down> x<BS><down>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" fzf runtime path (brew-aware)
if executable('brew')
  let fzf_prefix = trim(system('brew --prefix fzf 2>/dev/null'))
  if !empty(fzf_prefix) && isdirectory(fzf_prefix)
    execute 'set rtp+=' . fzf_prefix
  endif
endif

" fuck the intro screen and the 'Press ENTER' message:
set showcmd
set shortmess=atI

" 2-space indent for html and json files
autocmd BufRead,BufNewFile *.json,*.html,*.css,*.svg set sw=2 tabstop=2
autocmd BufRead,BufNewFile Makefile,makefile,*Makefile,*makefile set noexpandtab
