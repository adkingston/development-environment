" PLUGINS

call plug#begin(~/.config/nvim/plugged)

Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'

call plug#end()

" colour: 

color dracula
syntax enable 

" spacing 

set tabstop=4|
set softtabstop=4|
set expandtab|

" movement

nnoremap j gj 
nnoremap k gk

nnoremap B ^ 
nnoremap E $

nnoremap $ <nop> 
nnoremap ^ <nop>

inoremap jk <esc>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O 
inoremap {;<CR> {<CR>};<ESC>0

inoremap <C-sp> <C-ww> 

" UI config 
set number |
set cursorline |
set lazyredraw |
set showmatch |
set showcmd |


" search
set incsearch |
set hlsearch



