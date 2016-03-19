"  ---------------------- ABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting
" https://gosukiwi.svbtle.com/vim-configuration-for-web-development

" turn on syntax highlighting
syntax on
" and show line numbers
set number

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" by default, in insert mode backspace won't delete over line breaks, or
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" ---------------------- CUSTOMIZATION ----------------------
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience

" unmap spacebar in normal mode
nnoremap <Space> <nop>

" set , as mapleader
let mapleader = ","

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" windows like clipboard
" yank to and paste from the clipboard without prepending "* to commands
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" map c-x and c-v to work as they do in windows, only in insert mode
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

" save with ctrl+s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" allow Tab and Shift+Tab to
" tab  selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" remove the .ext~ files, but not the swapfiles
set nobackup
set nowb
set noswapfile

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default
" use ESC to remove search higlight
nnoremap <esc> :noh<return><esc>

" most of the time I should use ` instead of ' but typing it with my keyabord
" is a pain, so just toggle them
nnoremap ' `
nnoremap ` '

" suggestion for normal mode commands
set wildmode=list:longest

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" indentation
set expandtab       " use spaces instead of tabs
set smarttab
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces

map <space> /
map <C-space> ?
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" no lines longer than 80 cols
set textwidth=80

" use <C-Space> for Vim's keyword autocomplete
"  ...in the terminal
inoremap <Nul> <C-n>
"  ...and in gui mode
inoremap <C-Space> <C-n>
inoremap jk <ESC>

" On file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   .twig files use html syntax
autocmd BufNewFile,BufRead *.twig setlocal ft=html
"   .less files use less syntax
autocmd BufNewFile,BufRead *.less setlocal ft=less
"   .jade files use jade syntax
autocmd BufNewFile,BufRead *.jade setlocal ft=jade

" when pasting over SSH it's a pain to type :set paste and :set nopaste
" just map it to <f9>
set pastetoggle=<f9>

" if windows...
if has('win32')
" start maximized
autocmd GUIEnter * simalt ~x
" also use .vim instead of vimfiles, make sure to run the following command
" once this was copied to /Users/<user>/.vim
"  mklink %homepath%/.vimrc %homepath%/.vim/.vimrc
let &runtimepath.=',$HOME/.vim'
endif

" select all mapping
noremap <leader>a ggVG

" ---------------------- PLUGIN CONFIGURATION ----------------------
" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" You can specify revision/branch/tag.
call dein#add('takac/vim-hardtime')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-scripts/L9')
call dein#add('vim-scripts/FuzzyFinder')
call dein#add('itchyny/lightline.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('elentok/plaintasks.vim')
call dein#add('dhruvasagar/vim-dotoo')
call dein#add('jiangmiao/auto-pairs')
" -- Web Development
call dein#add('mattn/emmet-vim')
call dein#add('skammer/vim-css-color')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('digitaltoad/vim-pug')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" start NERDTree on start-up and focus active window
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" map FuzzyFinder
noremap <leader>b :FufBuffer<cr>
noremap <leader>f :FufFile<cr>

" use zencoding with <C-E>
let g:user_emmet_leader_key = '<C-e>'

" set the color theme to wombat256i
" set background=dark
colorscheme brogrammer 
" make a mark for column 80
" set colorcolumn=80
" and set the mark color to DarkSlateGray
highlight ColorColumn ctermbg=lightgray guibg=lightgray
