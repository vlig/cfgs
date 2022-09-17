syntax on
set number
set ignorecase
set smartcase

"mkdir ~/.vimtmp
set backup
set backupdir=~/.vimtmp//,.
set directory=~/.vimtmp//,.
set undodir=~/.vimtmp//,.

set laststatus=2
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]
colorscheme murphy

nnoremap <cr> :noh<cr><cr>:<backspace> " убрать подсвечивание результата поиска

" Remember position of last edit and return on reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
