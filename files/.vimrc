" ------------------ GENERAL ------------------
set nocompatible              						" be iMproved, required
set t_CO=256
so ~/.vim/plugins.vim							"Load plugins.

syntax on
colorscheme base16-monokaipro-spectrum

set backspace=indent,eol,start						"Make backspace delete indentation, whitespace ect
let mapleader= ','							"Comma should be the leader

" ------------------ MAPPINGS ------------------
nmap <Leader>ev 	:tabedit $MYVIMRC<cr>				"Edit the .vimrc. 
nmap <Leader>ez	 	:tabedit ~/.zshrc<cr>				"Edit the .zshrc. 
nmap <Leader>ewm	:tabedit ~/.config/i3/config<cr>		"Edit the i3 config. 
nmap <Leader>epb	:tabedit ~/.config/polybar/config<cr>		"Edit the polybar config. 
nmap <Leader><space>	:nohlsearch<cr>					"Hide search results.


" ------------------ SEARCH ------------------
set hlsearch
set incsearch
" ------------------ AUTO COMMANDS ------------------
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %					"Source the .vimrc every time we save it
	autocmd BufWritePost .zshrc source %					"Source the .zshrc every time we save it
augroup END
