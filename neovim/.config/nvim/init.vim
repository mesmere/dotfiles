set title
set whichwrap+=<,>,[,]
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
set number
autocmd FileType gitcommit set colorcolumn=+1
set clipboard+=unnamedplus
set expandtab shiftwidth=2 tabstop=2 cino=+4
noremap <expr> <C-d> winheight(0) . '<C-d>'
noremap <expr> <C-u> winheight(0) . '<C-u>'
imap <expr> <PageDown> '<C-o>' . winheight(0) . '<C-d>'
imap <expr> <PageUp> '<C-o>' . winheight(0) . '<C-u>'
