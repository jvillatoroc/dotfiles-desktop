syntax enable			" enable syntax processing

" UI Config
set number			" show line numbers
set relativenumber		" show relative line numbers
execute pathogen#infect()
syntax on			" load filetype-specific indent files
filetype plugin indent on	" load filetype-specific indent files
set encoding=utf-8		" set encoding to utf-8

inoremap <Space><Space><Space> <Esc>/<++><Enter>"_c4l

autocmd FileType tex inoremap ;gr \includegraphics[width=\textwidth]{}<Space><++><Esc>B2hi

" limit mail text width to 72 characters
au BufRead /tmp/mutt-* set tw=72

" Recompile suckless programs automatically:
	autocmd BufWritePost config.h,config.def.h !make && make clean && sudo make install

" Recompile LaTeX documents automatically:
	autocmd BufWritePost *.tex !pdflatex %

" Reload .Xresources automatically:
	autocmd BufWritePost Xresources !xrdb Xresources
	autocmd BufWritePost .config/Xresources !xrdb .config/Xresources
