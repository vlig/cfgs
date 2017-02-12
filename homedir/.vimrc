execute pathogen#infect()
syntax on
filetype plugin indent on

" Tweaks for cyrillic: https://habrahabr.ru/post/98393/
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
" set spelllang=ru_yo,en_us

set number
set nobackup
" set nowritebackup

set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

