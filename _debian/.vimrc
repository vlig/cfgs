syntax on
set number
set ignorecase
set smartcase
set backspace=indent,eol,start

" set viminfo+=n$VIM/_viminfo  " for Windows

" mkdir ~/.vimtmp or _vimtmp in $VIM dir for Windows: $VIM/_vimtmp//,.
set backup
set backupdir=~/.vimtmp//,.
set directory=~/.vimtmp//,.
set undodir=~/.vimtmp//,.

set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]
set t_Co=256

colorscheme murphy
"colorscheme delek " for true console

nnoremap <cr> :noh<cr><cr>:<backspace>  " remove search results highlights

" Remember position of last edit and return on reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" For Cyrillic
""""""""""""""

" https://habrahabr.ru/post/98393/
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
"set keymap=russian-jcukenwin
"set iminsert=0
"set imsearch=0
"highlight lCursor guifg=NONE guibg=Cyan
setlocal spelllang=ru_yo,en_us

" https://github.com/lyokha/vim-xkbswitch
"let g:XkbSwitchEnabled = 1
"let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
"let g:XkbSwitchAssistSKeymap = 1    " for search lines
