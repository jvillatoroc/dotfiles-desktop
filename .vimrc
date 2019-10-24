syntax enable			" enable syntax processing

" UI Config
set number			" show line numbers
set relativenumber		" show relative line numbers
execute pathogen#infect()
syntax on			" load filetype-specific indent files
filetype plugin indent on	" load filetype-specific indent files
set encoding=utf-8		" set encoding to utf-8

" limit mail text width to 72 characters
au BufRead /tmp/mutt-* set tw=72

" Recompile suckless programs automatically:
	autocmd BufWritePost config.h,config.def.h !make && make clean && sudo make install

