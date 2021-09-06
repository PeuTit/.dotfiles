" Set number
set number

" Enable syntax highlighting
syntax on

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Use space instead of tabs
set expandtab

" 1 tab = 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=4

" Indent according to the code
set smartindent
set autoindent

" Ctrl + s to save file
map <C-s> :w<CR>
 
 " Return to last edit position when opening files (You want this!)
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

 " Delete trailing white space on save, useful for some filetypes ;)
 fun! CleanExtraSpaces()
   let save_cursor = getpos(".")
   let old_query = getreg('/')
   silent! %s/\s\+$//e
   call setpos('.', save_cursor)
   call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Autocomplete characters such as {, [, (, ' and "
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Toggle comment 
autocmd FileType sh,ruby,python   let b:comment_leader = '#'
autocmd FileType conf,fstab       let b:comment_leader = '#'
autocmd FileType vim              let b:comment_leader = '"'
function! CommentToggle()
  execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
  execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
map <C-_> :call CommentToggle()<CR>
