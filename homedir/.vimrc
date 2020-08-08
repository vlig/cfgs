set number                                                                                                                                                              
set nobackup
" set nowritebackup
set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

nnoremap <cr> :noh<cr><cr>:<backspace> " убрать подсвечивание результата поиска

" Настройки для кириллицы
"""""""""""""""""""""""""

" https://habrahabr.ru/post/98393/
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
setlocal spelllang=ru_yo,en_us

" https://github.com/lyokha/vim-xkbswitch
"let g:XkbSwitchEnabled = 1
"let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
"let g:XkbSwitchAssistSKeymap = 1    " for search lines
