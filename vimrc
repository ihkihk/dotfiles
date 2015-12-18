filetype off
call pathogen#infect()
call pathogen#helptags()


set background=light
"colorscheme hybrid
colorscheme solarized

" These are the colors of EOL (SpecialKey is for TAB/NBSP; NonText for EOL)
hi SpecialKey ctermfg=252
hi NonText ctermfg=254


" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" We're in the 21st century and don't need and backward compatibility with vi
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu
set wildmode=list:longest

" Show partial commands in the last line of the screen
set showcmd

set incsearch
set showmatch
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Repair the horrible broken regexp handling and make it PCRE compatible
nnoremap / /\v
vnoremap / /\v

" Apply substitions globally on lines, i.e. add /g to :%s/foo/bar
set gdefault

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" Some more options as seen on
" http://stevelosh.com/blog/2010/09/coming-home-to-vim
set encoding=utf-8
set scrolloff=3
set showmode
set cursorline
set ttyfast
set relativenumber
set undofile


"------------------------------------------------------------
" Usability options {{{1
"
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Allow folding with za
set foldmethod=indent
set foldlevel=99

" Remap the leader key from the default \ to ,
let mapleader=","

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"------------------------------------------------------------
" Handle long lines {{{1
"
" Handle long lines correctly

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Show invisible characters
set list
set listchars=tab:▸\ ,eol:¬

" Fix j and k to move by screen lines and not in some archaic mode of file
" lines
nnoremap j gj
nnoremap k gk

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

inoremap jj <ESC>


map <F5> <esc>:w<CR>:bnext<CR>
map <S-F5> <esc>:w<CR>:bprev<CR>
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:pep8_map='<leader>8'
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
nmap <leader>a <Esc>:Ack!
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
map <leader>n :NERDTreeToggle<CR>
let g:ackprg = 'ag --vimgrep'
" Make ,W remove all white space
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip
" Open .vimrc in a side window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Open a vertical split and immediately switch over to it
nnoremap <leader>w <C-w>v<C-w>l
" Remap the keys used to move around the splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd BufRead *.py set makeprg=python3\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
inoremap <F8> <ESC>:!python3 %<CR>
nnoremap <F8> :!python3 %<CR>

"------------------------------------------------------------

au BufNewFile,BufRead *.md set filetype=markdown
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Like in TextMate - save the buffer always on changing
" When was the last time you didn't want this?
au FocusLost * :wa

