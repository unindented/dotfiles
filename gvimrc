" ------------------------------------------------------------------------------
" TOOLBARS & SCROLLBARS
" ------------------------------------------------------------------------------

set guioptions-=T  " Remove toolbar
set guioptions-=L  " Remove left-hand scroll bar
set guioptions-=r  " Remove right-hand scroll bar

" ------------------------------------------------------------------------------
" FONTS
" ------------------------------------------------------------------------------

if has("gui_gtk2")
  set guifont=Inconsolata-dz\ 12
else
  set guifont=Inconsolata-dz:h14
endif
