" ------------------------------------------------------------------------------
" ESSENTIALS
" ------------------------------------------------------------------------------

" Better safe than sorry.
set nocompatible

" All hail the mapleader.
let mapleader=","

" Load Pathogen.
execute pathogen#infect()

" Sane indentation.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" No backup or swap files.
set nobackup
set noswapfile

" No beeps.
set visualbell
set noerrorbells

" Join with one space.
set nojoinspaces

" Sane search and replace.
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set hlsearch
set gdefault

" Show mode.
set showmode

" Show relative numbers.
set relativenumber

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------

" Happy fingers.
nnoremap ; :
inoremap jj <ESC>

" Disable arrows.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Navigate displayed lines.
nnoremap j gj
nnoremap k gk

" Navigate windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows.
nnoremap <silent> <leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Match bracket pairs.
nnoremap <tab> %
vnoremap <tab> %

" Toggle fold.
nnoremap <space> za
vnoremap <space> za

" Clear last search.
nnoremap <silent> <leader><space> :noh<CR>

" Quickly close the current window.
nnoremap <leader>q :q<CR>

" Quickly write the current buffer.
nnoremap <leader>w :w<CR>

" Delete a line without adding it to the yanked stack.
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Yank to the end of the line.
nnoremap Y y$

" Yank and paste to the OS clipboard.
nnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>p "+p

" Toggle paste.
nnoremap <leader>i :set invpaste paste?<CR>

" Strip trailing whitespace.
function! StripWhitespace()
  let save_cursor=getpos(".")
  let old_query=getreg("/")
  :%s/\s\+$//e
  call setpos(".", save_cursor)
  call setreg("/", old_query)
endfunction
nnoremap <silent> <leader>s :call StripWhitespace()<CR>

" ------------------------------------------------------------------------------
" AUTOWRITE
" ------------------------------------------------------------------------------

" Write on buffer leave or blur.
autocmd BufLeave,FocusLost * silent! wa

" ------------------------------------------------------------------------------
" FOLDING
" ------------------------------------------------------------------------------

" Fold by indentation.
set foldmethod=indent
set foldenable

" Expand all folds.
autocmd BufEnter * let &foldlevel=max(map(range(1, line('$')), 'foldlevel(v:val)'))

" ------------------------------------------------------------------------------
" VIMDIFF
" ------------------------------------------------------------------------------

" Mappings.
nnoremap <leader>dl :diffget LO<CR>
nnoremap <leader>dr :diffget RE<CR>
nnoremap <leader>db :diffget BA<CR>

" ------------------------------------------------------------------------------
" RIPGREP
" ------------------------------------------------------------------------------

" Mappings.
nnoremap <leader>g :Rg<space>

" ------------------------------------------------------------------------------
" NERDTREE
" ------------------------------------------------------------------------------

" Mappings.
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeFind<CR>

" Show hidden files by default.
let NERDTreeShowHidden=1

" Open on startup if no files were specified.
autocmd VimEnter * if !argc() | NERDTree | endif

" Quit if only buffer left.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ------------------------------------------------------------------------------
" TAGBAR
" ------------------------------------------------------------------------------

" Mappings.
nnoremap <leader>t :TagbarToggle<CR>

" ------------------------------------------------------------------------------
" SYNTASTIC
" ------------------------------------------------------------------------------

" Sensible defaults.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Checkers.
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_lua_checkers = ['luac', 'luacheck']

" ------------------------------------------------------------------------------
" SLIME
" ------------------------------------------------------------------------------

" Use tmux.
let g:slime_target = "tmux"

" Set default config.
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}

" ------------------------------------------------------------------------------
" APPEARANCE
" ------------------------------------------------------------------------------

" Invisible chars.
set listchars=""
set listchars+=tab:>-
set listchars+=eol:¬
set listchars+=trail:Ø
set listchars+=extends:>
set listchars+=precedes:<
set list

" Long lines.
set colorcolumn=101

" Colors.
set background=dark

" Color theme.
let g:solarized_contrast="normal"
let g:solarized_visibility="low"
colorscheme solarized

" Status line.
if has("statusline") && !&cp
  set statusline=
  set statusline+=%3.3n\                         " Buffers
  set statusline+=%f\                            " Filename
  set statusline+=%m%r\                          " Flags
  set statusline+=%{fugitive#statusline()}\      " Fugitive status
  set statusline+=%{SyntasticStatuslineFlag()}\  " Syntastic status
  set statusline+=%=
  set statusline+=[%p%%]                         " Percentage
  set statusline+=[%l/%L]\                       " Line
  set statusline+=[%v]                           " Column
  set statusline+=[0x%04B]\                      " Character
  set statusline+=%*
endif
