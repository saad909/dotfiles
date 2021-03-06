hi Comment cterm=italic
let g:nvcode_termcolors=256

syntax on
" colorscheme nord
" colorscheme nvcode
" colorscheme dracula
" colorscheme onedark
" colorscheme TSnazzy
" colorscheme aurora

colorscheme gruvbox-material
" colorscheme gruvbox
" colorscheme wal

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
